return {
	servers = {
		rust_analyzer = {
			settings = {
				['rust-analyzer'] = {
					cargo = { allFeatures = true },
					checkOnSave = {
						command = 'cargo clippy',
						extraArgs = { '--no-deps' }
					}
				}
			}
		}
	},
}
