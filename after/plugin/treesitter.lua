local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
	return
end

configs.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "help", "python", "c", "cpp", "lua", "rust", "toml" },

	autopairs = {
		enable = true,
	},

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "" },

	indent = { enable = true, disable = { 'yaml', 'python', 'css' } },
}
