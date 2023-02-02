local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
	print("Couldn't find bufferline plugin!")
	return
end

bufferline.setup {
	options = {
		color_icons = true,
		indicator = { style = "icon", icon = "▎"},
		buffer_close_icon = "",
		modified_icon = "●",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = false,
	},
}
