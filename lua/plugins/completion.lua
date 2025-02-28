return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    -- find more here: https://www.nerdfonts.com/cheat-sheet
    kind_icons = {
      Array = "",
      Boolean = "",
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "󰉋",
      Function = "",
      Interface = "",
      Key = "",
      Keyword = "",
      Method = "",
      Module = "",
      Namespace = "",
      Null = "󰟢",
      Number = "",
      Object = "",
      Operator = "",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "",
      Struct = "",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "",
    },
    disabled_commands = {
      IncRename = true,
    },
  },
  config = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      enabled = function()
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          local cmd = vim.fn.getcmdline():match("%S+")
          -- disable completion in comments
          return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
            -- and in specific commands
            and (not opts.disabled_commands[cmd] or cmp.close())
        end
      end,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        -- Item selection
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- Docs scroll
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Pull up completion menu without typing
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- ["<CR>"] = cmp.mapping(function(fallback)
        -- 	if cmp.visible() then
        -- 		if luasnip.expandable() then
        -- 			luasnip.expand()
        -- 		else
        -- 			cmp.confirm({ select = true })
        -- 		end
        -- 	else
        -- 		fallback()
        -- 	end
        -- end),
        -- Supertab-like mapping
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", opts.kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      confirm_opts = {
        behaviour = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        -- Note: noice.nvim doesn't seem to be able to overwrite this one
        -- so we set it up here ourselves
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
        },
      },
      view = {
        entries = {
          name = "custom",
          -- Make selection window go bottom to top when cursor is low
          selection_order = "near_cursor",
        },
      },
    })
  end,
}
