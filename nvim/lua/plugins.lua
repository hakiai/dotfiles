require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<Leader>f", "<cmd>Telescope find_files<CR>"},
      {"<Leader>a", "<cmd>Telescope live_grep<CR>"},
    }
  }
})
