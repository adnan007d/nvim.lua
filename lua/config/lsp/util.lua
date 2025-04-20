local M = {}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("MyLspAttach", {}),
	callback = function(args)
		local opts = { buffer = args.buf, remap = false }

		---@param mode string|string[] Mode short-name, see |nvim_set_keymap()|.
		---                            Can also be list of modes to create mapping on multiple modes.
		---@param lhs string           Left-hand side |{lhs}| of the mapping.
		---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
		---
		---@param _opts? vim.keymap.set.Opts
		local function map(mode, lhs, rhs, _opts)
			vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", _opts or {}, opts))
		end

		-- Builtin Autocomplete: (Bit buggy)
		-- local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- if client:supports_method('textDocument/completion') then
		-- 	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		-- end

		-- formatting
		map("n", "<leader>f", function()
			require("conform").format({ bufnr = opts.bufnr, async = true, lsp_format = "fallback" })
		end, { desc = "Format buffer async with Conform and fallback to LSP" })

		map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
		map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols" })
		map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Open Diagnostic Float for Under Cursor" })
		map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set Diagnostic Loclist" })
		map("n", "[d",
			function() vim.diagnostic.jump({ count = -1, float = true }) end,
			{ desc = "Go to Previous Diagnostic" })
		map("n", "]d",
			function() vim.diagnostic.jump({ count = -1, float = true }) end,
			{ desc = "Go to Next Diagnostic" })
		-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		-- map("n", "<leader>rr", vim.lsp.buf.references, { desc = "References" })
		-- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
		map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

		local telescope = require("telescope.builtin")
		map("n", "gr", telescope.lsp_references, { desc = "References (Telescope)" })
		map("n", "gI", telescope.lsp_implementations, { desc = "Implementations (Telescope)" })
		map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
		map("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "Document Symbols" })
		map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })

		-- Lesser used LSP functionality
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List Workspace Folders" })
	end,
})

M.on_attach = function(client)
	if client.name == "ts_ls" then
		vim.keymap.set("n", "<leader>tc", ":TSC<CR>", { desc = "Typescript: Compile" })
		vim.keymap.set("n", "<leader>tcs", ":TSCStop<CR>", { desc = "Typescript: Stop" })
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local function getHomeDirectory()
	if jit.os ~= "Windows" then
		-- Windows
		return os.getenv("USERPROFILE") or os.getenv("HOME")
	else
		-- Unix-like systems
		return os.getenv("HOME")
	end
end

M.getHomeDirectory = getHomeDirectory

return M
