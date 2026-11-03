-- Keep this list short: nvim is used as a plain text editor.
-- Commenting (gc), syntax highlighting and terminals come from Neovim / WezTerm.
return {
  -- Colorscheme (matches the WezTerm color scheme)
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  -- Edit directories as buffers
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    opts = {},
    keys = {
      { '\\', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
  },

  -- Fuzzy finder (uses the fzf and rg binaries)
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {},
    keys = {
      { '<space>f', '<CMD>FzfLua files<CR>', desc = 'Find files' },
      { '<space>g', '<CMD>FzfLua live_grep<CR>', desc = 'Live grep' },
      { '<space>b', '<CMD>FzfLua buffers<CR>', desc = 'Buffers' },
      { '<space>h', '<CMD>FzfLua helptags<CR>', desc = 'Help tags' },
      { '<space><space>', '<CMD>FzfLua commands<CR>', desc = 'Commands' },
    },
  },

  -- Inline completion (accept with <Tab>). Loaded at startup: copilot.vim does not
  -- attach to buffers that were opened before it is loaded.
  {
    'github/copilot.vim',
    lazy = false,
    init = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
      }
    end,
  },
}
