return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "",
              package_pending = "",
              package_uninstalled = "",
            },
          },
          log_level = vim.log.levels.INFO,
          max_concurrent_installers = 10,
        },
        build = ":MasonUpdate",
        run = ":MasonUpdate",
      },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = "BufReadPost",
    -- lazy = false,
    opts = {
      -- servers to configure and install
      servers = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "pyright",
        "texlab",
        "html",
        "cssls",
        "jdtls",
        "bashls",
      },
      diagnositcs_config = {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
    config = function(_, opts)
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = opts.servers,
      })

      -- Customize particular server
      local on_attach = function(client, bufnr)
        require("plugins.lsp.keymaps")(bufnr)

        -- Highlights
        if client.server_capabilities.documentHighlightProvider then
          local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = lsp_document_highlight,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertLeave" }, {
            group = lsp_document_highlight,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- client.server_capabilities.semanticTokensProvider = nil
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      vim.diagnostic.config(opts.diagnositcs_config)
      local handlers = {
        -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        -- 	border = "single",
        -- }),
        -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        -- 	border = "single",
        -- }),
      }

      local base_conf = {
        on_attach = on_attach,
        handlers = handlers,
        capabilities = capabilities,
      }

      -- Custom settings for some servers
      local lspconfig = require("lspconfig")
      for _, server in ipairs(opts.servers) do
        local require_ok, server_conf = pcall(require, "plugins.lsp.settings." .. server)
        local extra = {}
        if require_ok then
          extra = server_conf
        end
        local conf = vim.tbl_deep_extend("force", base_conf, extra)

        lspconfig[server].setup(conf)
      end
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    keys = {
      { "<leader>rn", ":IncRename ", noremap = true, silent = true },
    },
    opts = {},
  },
}
