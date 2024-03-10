-- Autocompletion
local Plugin = { "hrsh7th/nvim-cmp" }
local user = { autocomplete = true }

Plugin.dependencies = {
	-- Sources
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
}

Plugin.event = "InsertEnter"

function Plugin.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local select_opts = { behavior = cmp.SelectBehavior.Select }

	local kind_icons = {
		Text = "󰉿",
		Method = "m",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰆧",
		Class = "󰌗",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰇽",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰊄",
		Codeium = "󰚩",
		Copilot = "",
	}

	user.config = {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "clangd" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "luasnip", keyword_length = 3 },
			{ name = "path" },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					luasnip = "",
					buffer = "",
					path = "",
					emoji = "",
				})[entry.source.name]
				return vim_item
			end,
		},
		mapping = {
			["<C-b>"] = cmp.mapping.scroll_docs(-5),
			["<C-f>"] = cmp.mapping.scroll_docs(5),

			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),

			["<C-n>"] = cmp.mapping.select_next_item(select_opts),
			["<C-p>"] = cmp.mapping.select_prev_item(select_opts),

			["<C-Space>"] = cmp.mapping.complete({}),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),

			["<C-l>"] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { "i", "s" }),

			["<C-h>"] = cmp.mapping(function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { "i", "s" }),
		},
		experimental = {
			ghost_text = true,
		},
	}

	cmp.setup(user.config)
end

function user.set_autocomplete(new_value)
	local old_value = user.autocomplete

	if new_value == old_value then
		return
	end

	if new_value == false then
		-- restore autocomplete in the next word
		vim.api.nvim_buf_set_keymap(0, "i", "<space>", "<cmd>UserCmpEnable<cr><space>", { noremap = true })

		-- restore when leaving insert mode
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = user.augroup,
			command = "UserCmpEnable",
			once = true,
		})
	end

	user.autocomplete = new_value
end

function user.check_back_space()
	local col = vim.fn.col(".") - 1
	if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		return true
	else
		return false
	end
end

function user.enable_cmd()
	if user.autocomplete then
		return
	end

	pcall(vim.api.nvim_buf_del_keymap, 0, "i", "<Space>")
	user.set_autocomplete(true)
end

function user.insert_tab()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
end

return Plugin
