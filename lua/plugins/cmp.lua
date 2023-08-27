-- Autocompletion
local Plugin = { 'hrsh7th/nvim-cmp' }
local user = { autocomplete = true }

Plugin.dependencies = {
	-- Sources
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lua' },

	-- Snippets
	{ 'L3MON4D3/LuaSnip' },
}

Plugin.event = 'InsertEnter'

function Plugin.config()
	user.augroup = vim.api.nvim_create_augroup('compe_cmds', { clear = true })
	vim.api.nvim_create_user_command('UserCmpEnable', user.enable_cmd, {})

	local cmp = require('cmp')
	local luasnip = require('luasnip')

	local select_opts = { behavior = cmp.SelectBehavior.Select }
	local cmp_enable = cmp.get_config().enabled

	user.config = {
		enabled = function()
			if user.autocomplete then
				return cmp_enable()
			end

			return false
		end,
		completion = {
			completeopt = 'menu,menuone',
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lua' },
			{ name = 'nvim_lsp',               keyword_length = 3 },
			{ name = 'buffer',                 keyword_length = 3 },
			{ name = 'luasnip',                keyword_length = 2 },
			{ name = 'path' },
			{ name = 'buffer' },
		},
		window = {
			documentation = {
				border = 'rounded',
				max_height = 15,
				max_width = 50,
				zindex = 50,
			}
		},
		formatting = {
			fields = { 'menu', 'abbr', 'kind' },
			format = function(entry, item)
				local menu_icon = {
					nvim_lsp = 'λ',
					luasnip = '⋗',
					buffer = 'Ω',
					path = '🖫',
					nvim_lua = 'Π',
				}

				item.menu = menu_icon[entry.source.name]
				return item
			end,
		},
		mapping = {
			['<C-b>'] = cmp.mapping.scroll_docs(-5),
			['<C-f>'] = cmp.mapping.scroll_docs(5),

			['<C-e>'] = cmp.mapping {
				i = cmp.mapping.abort(),
				c = cmp.mapping.close()
			},

			['<C-j>'] = cmp.mapping.select_prev_item(select_opts),
			['<C-k>'] = cmp.mapping.select_next_item(select_opts),

			['<C-Space>'] = cmp.mapping.complete {},
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},

			['<C-a>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<C-d>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				elseif luasnip.jumpable(1) then
					luasnip.jump(1)
				elseif user.check_back_space() then
					fallback()
				else
					user.set_autocomplete(true)
					cmp.complete()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					user.insert_tab()
				end
			end, { 'i', 's' }),
		}
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
		vim.api.nvim_buf_set_keymap(
			0,
			'i',
			'<space>',
			'<cmd>UserCmpEnable<cr><space>',
			{ noremap = true }
		)

		-- restore when leaving insert mode
		vim.api.nvim_create_autocmd('InsertLeave', {
			group = user.augroup,
			command = 'UserCmpEnable',
			once = true,
		})
	end

	user.autocomplete = new_value
end

function user.check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

function user.enable_cmd()
	if user.autocomplete then
		return
	end

	pcall(vim.api.nvim_buf_del_keymap, 0, 'i', '<Space>')
	user.set_autocomplete(true)
end

function user.insert_tab()
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes('<Tab>', true, true, true),
		'n',
		true
	)
end

return Plugin

