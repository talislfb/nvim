-- personal simple statusline
-- mostly taken from: https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

-- catppuccin colors
local catppuccin = require("catppuccin.palettes").get_palette("mocha")

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = catppuccin.Lavender
	if current_mode == "i" then
		mode_color = catppuccin.Blue
	elseif current_mode == "v" then
		mode_color = catppuccin.Saphire
	elseif current_mode == "R" then
		mode_color = catppuccin.Peach
	elseif current_mode == "c" then
		mode_color = catppuccin.Mauve
	elseif current_mode == "t" then
		mode_color = catppuccin.Red
	end
	return mode_color
end

-- the expand function uses the following options:
-- :~ - reduces filename to be relative to the home directory, i.e. replace /home/<user> with ~.
-- :. - reduces filename to be relative to the current directory.
-- :h - reduces filename to only the head (without this it would be printed twice.)
local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s\\", fpath)
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):upper()
end

-- %P - Percentage through the file.
-- %l - Line Number
-- %c - Column Number
local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c"
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		errors = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		errors = " %#LspDiagnosticsSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		errors = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsAdd# ",
		git_info.head,
		" %#Normal#",
	})
end

Statusline = {}

vim.api.nvim_exec(
	[[
  hi PrimaryBlock   ctermfg=06 ctermbg=00
  hi SecondaryBlock ctermfg=08 ctermbg=00
  hi Blanks   ctermfg=07 ctermbg=00
]],
	false
)

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		mode(),
		"%#SecondaryBlock#",
		filepath(),
		filename(),
		"%#Normal#",
		vcs(),
		lsp(),
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	})
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#  NetRW"
end

vim.api.nvim_exec(
	[[
		augroup Statusline
		au!
		au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
		au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
		au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
		augroup END
	]],
	false
)
