return {
	servers = {
		settings = {
			['rust-analyzer'] = {
				assist = {
					importEnforceGranularity = true,
					importPrefix = "crate",
				},
				cargo = { allFeatures = true },
				checkOnSave = {
					command = 'cargo clippy',
					extraArgs = { '--no-deps' }
				},
				inlayHints = {
					lifetimeElisionHints = {
						enable = true,
						useParameterNames = true,
					}
				}
			},
			dap = {
				adapter = {
					type = "executable",
					command = "lldb-vscode",
					name = "rt_lldb"
				}
			},
			cmd = {
				"rustup", "run", "stable" "rust-analyzer",
			}
		},
	},
}
