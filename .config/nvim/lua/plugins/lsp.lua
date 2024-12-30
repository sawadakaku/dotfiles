return {
  {
    'neovim/nvim-lspconfig'
  },
  {
    'williamboman/mason.nvim',
    config = true
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local config = {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
          require('lspconfig')[server_name].setup(config)
        end,
        -- rust_analyzer = function()
        --   require('rust-tools').setup({})
        -- end,
      })
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      local lspsaga = require('lspsaga')
      lspsaga.setup({})
      local map = require('utils').map
      map('n', 'K', ':Lspsaga hover_doc<CR>', {silent = true})
      map('n', 'gh', ':Lspsaga finder<CR>', {silent = true})
      map('n', 'ga', ':Lspsaga code_action<CR>', {silent = true})
      map('n', 'gp', ':Lspsaga peek_definition<CR>', {silent = true})
      map('n', 'go', ':Lspsaga outline<CR>', {silent = true})
      map('n', 'gj', ':Lspsaga incoming_calls<CR>', {silent = true})
      map('n', 'gk', ':Lspsaga outgoing_calls<CR>', {silent = true})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  {
    'j-hui/fidget.nvim',
    opts = {}
  },
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    commands = {
      'Format',
    },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = {
            'stylua',
          },
        }
      })
      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format({ async = true, lsp_format = 'fallback', range = range })
      end, { range = true })
    end
  },
  {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    commands = {
      'Lint',
    },
    config = function()
      require('lint').linters_by_ft = {
        lua = {'luacheck'},
      }

      vim.api.nvim_create_user_command('Lint', function(args)
          require('lint').try_lint()
        end, {}
      )
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
  }
}
