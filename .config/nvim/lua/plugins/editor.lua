return {
  {
    'machakann/vim-sandwich',
    event = 'VeryLazy',
    -- va' -> sd, sr
    -- viw -> sa"
    -- cib
    -- cab
    -- sr"
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    "LudoPinelli/comment-box.nvim",
    event = 'VeryLazy',
  },
  {
    'ojroques/vim-oscyank',
    event = 'VeryLazy',
    config = function()
      map = require('utils').map
      map("v", "<leader>y", ":OSCYank<CR>", {noremap = true})
      map("v", "y", "y:OSCYankRegister \"<CR>", {noremap = true})
    end
  },
  {
    'thinca/vim-qfreplace',
    event = 'VeryLazy',
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = true,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
}
