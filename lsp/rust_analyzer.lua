return {
  filetypes = { "rs" },
  settings = {
    ["rust_analyzer"] = {
      procMacro = { enable = true },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
}
