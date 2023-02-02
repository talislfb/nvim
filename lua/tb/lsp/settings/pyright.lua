return {
	servers = {
		pyright = {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
					},
				}
			}
		}
	},
}
