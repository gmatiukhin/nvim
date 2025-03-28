-- https://github.com/rust-lang/rust-analyzer/tree/master/docs/user#settings
return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
        features = "all",
        allTargets = true,
        workspace = false,
      },
      cargo = {
        autoreload = true,
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      diagnostics = {
        disabled = { "macro-error" },
      },
    },
  },
}
