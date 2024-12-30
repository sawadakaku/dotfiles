return {
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'luasnip' },
          {
            name = 'spell',
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
              preselect_correct_word = true,
            },
          },
          { name = 'path' },
        }),
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
            end
          end, { 'i', 'c' }),
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
            end
          end, { 'i', 'c' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.confirm({select = true})
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's', 'c' }),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'f3fora/cmp-spell',
  'saadparwaiz1/cmp_luasnip',
  {
    'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },
    build = 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  }
}
