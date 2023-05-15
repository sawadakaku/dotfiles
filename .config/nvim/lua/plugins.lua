local packer = nil
local function init()
  if packer == nil then
    packer = require('packer')
    packer.init({disable_commands = true})
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use {'wbthomason/packer.nvim', opt = true}
  use 'lewis6991/impatient.nvim'
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
      require('notify').setup({
        timeout = 5000,
        background_colour = "#000000"
      })
    end
  }

  -----------------------------------------------------------------------
  -- Appearance
  -----------------------------------------------------------------------
  -- use {
  --   'PHSix/nvim-hybrid',
  --   config = function()
  --     require('hybrid').setup()
  --     -- or use
  --     -- vim.cmd [[colorscheme nvim-hybrid]]
  --   end
  -- }
  -- use {
  --   'EdenEast/nightfox.nvim',  -- color schema
  --   config = [[require('config.nightfox')]]
  -- }
  use {
    'rebelot/kanagawa.nvim',
    config = [[require('config.kanagawa')]]
  }
  use {
    'kyazdani42/nvim-web-devicons',
    config = [[require('config.web-devicons')]]
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[require('config.indent-blankline')]]
  }
  use {
    "folke/todo-comments.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      'folke/trouble.nvim'
    },
    config = [[require('config.todo-comments')]]
  }
  use {
    "petertriho/nvim-scrollbar",
    requires = {
      'kevinhwang91/nvim-hlslens',
    },
    config = [[require('config.nvim-scrollbar')]]
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    event = { 'VimEnter' },
    config = [[require('config.evil_lualine')]]
  }
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v2.x",
    requires = { 
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    keys = {{'n', '\\'}},
    config = [[require('config.neo-tree')]]
  }
  use {
    "akinsho/toggleterm.nvim",
    config = [[require('config.toggleterm')]]
  }
  use 'yuttie/comfortable-motion.vim'
  -- use {
  --   "lukas-reineke/virt-column.nvim",
  --   event = { 'VimEnter' },
  --   config = function()
  --     require("virt-column").setup()
  --   end
  -- }


  -----------------------------------------------------------------------
  -- Move
  -----------------------------------------------------------------------
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = [[require('config.hop')]]
  }

  -----------------------------------------------------------------------
  -- Search
  -----------------------------------------------------------------------
  use {
    'kevinhwang91/nvim-hlslens',
    config = [[require('config.hlslens')]]
  }

  -----------------------------------------------------------------------
  -- Completion
  -----------------------------------------------------------------------
  use {
    'hrsh7th/nvim-cmp',
    after = { 'LuaSnip' },
    config = [[require('config.cmp')]],
    requires = {
      {'hrsh7th/cmp-buffer', after='nvim-cmp'},
      {'hrsh7th/cmp-path', after='nvim-cmp'},
      {'hrsh7th/cmp-cmdline', after='nvim-cmp'},
      {'onsails/lspkind-nvim', after='nvim-cmp', require='kyazdani42/nvim-web-devicons'},
      {'hrsh7th/cmp-nvim-lsp', after='nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp-signature-help', after='nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp-document-symbol', after='nvim-cmp'},
      {'hrsh7th/cmp-emoji', after='nvim-cmp'},
      {'hrsh7th/cmp-calc', after='nvim-cmp'},
      {'uga-rosa/cmp-dictionary', after='nvim-cmp'},
      {'saadparwaiz1/cmp_luasnip', after='nvim-cmp', require='L3MON4D3/LuaSnip'},
      {'windwp/nvim-autopairs'}
    },
    event = 'InsertEnter *'
  }

  use {
    'L3MON4D3/LuaSnip',
    event = {'InsertEnter *'},
    config = [[require('config.luasnip')]],
    requires = {
      'rafamadriz/friendly-snippets'
    }
  }

  -----------------------------------------------------------------------
  -- Fuzzy Finder
  -----------------------------------------------------------------------
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {"nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sqlite.lua"}},
      {'stevearc/aerial.nvim', config=[[require('config.aerial')]]},
      {'rcarriga/nvim-notify'},
      {"nvim-telescope/telescope-live-grep-args.nvim"},
      {'nvim-telescope/telescope-ui-select.nvim'}
    },
    event = {'VimEnter'},
    config = [[require('config.telescope')]]
  }


  -----------------------------------------------------------------------
  -- Editor
  -----------------------------------------------------------------------
  -- va' -> sd, sr
  -- viw -> sa"
  -- cib
  -- cab
  -- sr"
  use 'machakann/vim-sandwich'
  -- <C-r> during insert mode
  -- " during normal mode
  use 'tversteeg/registers.nvim'
  use {
    'numToStr/Comment.nvim',
    tag = 'v0.6',
    config = function()
      require('Comment').setup()
    end
  }
  use{
    "LudoPinelli/comment-box.nvim",
    event = { 'VimEnter' }
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({map_cr = false})
    end
  }
  use {
    'ojroques/vim-oscyank',
    setup = function()
      -- vim.cmd("let g:oscyank_term = 'default'")
      vim.g.oscyank_term = 'default'
    end,
    config = function()
      -- vim.api.nvim_set_keymap("n", "<leader>y", "<Plug>OSCYank", {noremap = true})
      vim.api.nvim_set_keymap("v", "<leader>y", ":OSCYank<CR>", {noremap = true})
      vim.api.nvim_set_keymap("v", "y", "y:OSCYankReg \"<CR>", {noremap = true})
    end
  }
  use 'thinca/vim-qfreplace'

  -----------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------
  use {
    'neovim/nvim-lspconfig',
    event = { 'VimEnter' }
  }
  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'tami5/lspsaga.nvim',
        -- branch = 'nvim6.0',
        config = function()
          local lspsaga = require('lspsaga')
          lspsaga.setup()
        end
      }
    },
    after = { 'nvim-lspconfig' },
    config = [[require('config/lspconfig')]]
  }
  use {
    'folke/lsp-colors.nvim',
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  }
  use {
    'j-hui/fidget.nvim',
    after = { 'nvim-lspconfig' },
    config = function()
      require('fidget').setup()
    end
  }
  use {
    'folke/trouble.nvim',
    config = [[require('config.trouble')]]
  }

  -----------------------------------------------------------------------
  -- TreeSitter
  -----------------------------------------------------------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {'p00f/nvim-ts-rainbow'},
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = [[require('config.treesitter')]]
  }
  use {
    'haringsrob/nvim_context_vt',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim_context_vt').setup()
    end
  }
  use {
   'nvim-treesitter/playground',
   cmd = {
     'TSPlaygroundToggle',
     'TSHighlightCapturesUnderCursor'
   }
  }

  -----------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }


  -----------------------------------------------------------------------
  -- DAP
  -----------------------------------------------------------------------
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'
  -- use 'theHamsta/nvim-dap-virtual-text'
  -- use 'nvim-telescope/telescope-dap.nvim'


  -- -----------------------------------------------------------------------
  -- -- Language
  -- -----------------------------------------------------------------------
  -- -- use {
  -- --   'simrat39/rust-tools.nvim',
  -- --   config = [[require('config.rust-tools')]]
  -- -- }
  -- -- use {
  -- --   'p00f/clangd_extensions.nvim',
  -- --   config = [[require('config.clangd_extensions')]]
  -- -- }


  -----------------------------------------------------------------------
  -- Project, Session
  -----------------------------------------------------------------------
  use {
    'ahmedkhalf/project.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
    after = { 'telescope.nvim' },
    -- event = 'VimEnter',
    config = [[require('config.project')]]
  }
  -- use {
  --   'rmagatti/auto-session',
  --   event = 'VimEnter',
  --   config = function()
  --     require('auto-session').setup {
  --       log_level = 'info',
  --       auto_session_suppress_dirs = {'/disk2/kaku/', '~/'}
  --     }
  --   end
  -- }
  -- use {
  --   'rmagatti/session-lens',
  --   requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
  --   after = 'auto-session',
  --   config = function()
  --     require('session-lens').setup()
  --     vim.api.nvim_set_keymap("n", "<leader>P", "<cmd>lua require('session-lens').search_session()<CR>", {noremap = true})
  --   end
  -- }

  -----------------------------------------------------------------------
  -- Misc
  -----------------------------------------------------------------------
  use {
    'voldikss/vim-translator',
    event = 'VimEnter',
    config = function()
      vim.cmd("let g:translator_target_lang = 'ja'")
      vim.cmd("let g:translator_default_engines = ['google', 'bing']")
    end
  }

end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return plugins

