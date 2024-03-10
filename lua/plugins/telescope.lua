-- Fuzzy Finder
local Plugin = { "nvim-telescope/telescope.nvim" }
local user = {}

Plugin.dependencies = {
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope-fzy-native.nvim",
		build = function()
			user.build_fzy()
		end,
	},
}

Plugin.cmd = "Telescope"

function Plugin.init()
	local bind = vim.keymap.set

	-- Search pattern
	bind("n", "<leader>fa", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [A]ll (by Grep)" })

	-- Show key bindings list
	bind("n", "<leader>?", "<cmd>Telescope keymaps<cr>")
	bind("n", "<leader>fh", "<cmd>Telescope help_tags", { desc = "[F]ind help" })

	-- Find files by name
	bind("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "[F]ind [F]iles" })
	bind("n", "<leader>fgf", "<cmd>lua require('telescope.builtin').git_files()<cr>", { desc = "[F]ind [G]it [F]iles" })

	-- Search symbols in buffer
	bind("n", "<leader>fs", "<cmd>Telescope treesitter<cr>", { desc = "[F]ind [S]ymbols"} )

	-- Search buffer lines
	bind("n", "<leader>f/", function()
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[f/] Fuzzily search in current buffer" })

	-- Search in files history
	bind("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>")

	-- Search in active buffers list
	bind(
		"n",
		"<leader><space>",
		"<cmd>lua require('telescope.builtin').buffers()<cr>",
		{ desc = "[ ] Find existing buffers" }
	)
	bind(
		"n",
		"<leader>fr",
		"<cmd>lua require('telescope.builtin').oldfiles()<cr>",
		{ desc = "[F]ind [r]ecently opened files" }
	)
	bind(
		"n",
		"<leader>fw",
		"<cmd>lua require('telescope.builtin').grep_string()<cr>",
		{ desc = "[F]ind current [W]ord" }
	)
end

function Plugin.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
				},
			},
		},
		extension = {
			fzy_native = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},
		},
	})

	telescope.load_extension("fzy_native")
end

function user.job_output(cid, data, name)
	for i, val in pairs(data) do
		print(val)
	end
end

function user.build_fzy()
	if vim.fn.executable("make") == 0 then
		return
	end

	local workdir = vim.api.nvim_get_runtime_file("deps/fzy-lua-native", 1)

	if workdir[1] == nil then
		return
	end

	vim.fn.jobstart({ "make" }, {
		cwd = workdir[1],
		on_stdout = user.job_output,
	})
end

return Plugin
