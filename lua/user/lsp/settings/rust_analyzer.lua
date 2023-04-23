-- https://github.com/rust-lang/rust-analyzer/tree/master/docs/user#settings
return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        -- features = "all",
        overrideCommand = {
          "cargo",
          "clippy",
          "--workspace",
          "--message-format=json",
          "--all-targets",
          "--all-features",
        },
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
    },
  },
}
