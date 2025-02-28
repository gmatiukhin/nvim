-- https://github.com/luals/lua-language-server/blob/master/locale/en-us/setting.lua
-- Make lua's LSP not flag `vim` as waring
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      format = {
        enable = false,
      },
    },
  },
}
