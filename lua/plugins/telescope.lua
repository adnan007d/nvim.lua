return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			cond = function()
				return vim.fn.executable("cmake") == 1
			end,
		},
	},
	config = function(_)
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "^node_modules/" },
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Grep String" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>pr", builtin.resume, { desc = "Resume Last Search" })
		vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Diagnostics" })

		vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find Recently Opened Files" })
		vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find Existing Buffers" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				previewer = false,
			}))
		end, { desc = "Fuzzily Search in Current Buffer" })

		vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Keymaps" })
	end,
}
