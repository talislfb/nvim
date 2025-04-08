<img src="imgs/cpp-dap.png" alt="cpp debugging with dap">
<h2 align="center">
Talis' NeoVim VERY BASIC configuration
</h2>

# Table of Contents

- [Table of Contents](#table-of-contents)
- [My neovim setup](#my-neovim-setup)
- [References](#references)
- [Plugins](#plugins)
- [Requirements](#requirements)
- [LSP \& Debugging](#lsp--debugging)
  - [Python](#python)
  - [C/C++](#cc)

# My neovim setup

**IMPORTANT:** This a windows only configuration (for now) and is set for my own liking and there are still several things that I would to change in the future.
I'll keep on improving it's configuration for at least the following languages: lua, python and c/c++.

**Feel free to use/modify as you wish, at your own risk.**

# References

* [MrJakob](https://www.youtube.com/@MrJakob)'s youtube channel
* [Josean Martinez](https://www.youtube.com/@joseanmartinez)'s youtube channel
* [VonHeikemen](https://github.com/VonHeikemen/dotfiles/tree/master)'s dot files
* [Chris@Machine](https://www.youtube.com/@chrisatmachine)'s youtbune channel
* [Dreams of Code](https://www.youtube.com/@dreamsofcode/featured)'s youtube channel

# Plugins

[blink.cmp](https://github.com/saghen/blink.cmp) - Blink for lsp completion

[conform.nvim](https://github.com/stevearc/conform.nvim) - Conform for code formating

[fzf-lua](https://github.com/ibhagwan/fzf-lua) - For files navigation

[harpoon](https://github.com/ThePrimeagen/harpoon) - For favoriting files and swapping between them

[lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager for Neovim

[mason.nvim](https://github.com/williamboman/mason.nvim) - Package manager for LSP servers, DAP servers, linters and more

[nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol client implementation for neovim

[gitsigns](https://github.com/lewis6991/gitsigns.nvim) - Super fast git decorations implemented purely in lua/teal

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer

[mini.nvim](https://github.com/echasnovski/mini.nvim) - Several modules - icons, status line, file navigation

[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - Color theme

# Requirements
Run the neovim command `:checkhealth` for a full diagnose and missing dependecies.

* Neovim 0.11+ is required.
* Python 3.11
* Clangd
* Codelldb - I'm using the vscode extentsion for simplicity sake
* Lua
* Ripgrep for faster

# LSP & Debugging
New server configurations can be added to `lua/plugins/lsp/servers.lua` it can be manually started with the command `:Lsp {server_Name}`. Alternatively, there's a variable `auto_servers` in `lua/plugins/lsp/init.lua` that can be modified with new configuration names to be auto-started.

This configuration is set to have the ability to debug the following languages:
* Python
* C/C++

## Python
Python should be simple enough to just run the current file with dap.

## C/C++
* In order to Debug a c++ project is necessary to compile and generate the debug symbols.
* Then, **for now**, it's necessary to run the codelldb server (with port=1300)
  * The command for me is:
  * `~\\.vscode\\extensions\\vadimcn.vscode-lldb-1.9.2\\adapter\\codelldb.exe --port 13000`
* Setup your break points and start DAP by selecting the executable file.
