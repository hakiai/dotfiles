require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = "all",
        auto_install = true,
        highlight = {
          enable = true
        },
        autotag = {
          enable = true
        }
      })
    end
  },
  {
    'ibhagwan/fzf-lua', -- FUZZY検索
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {"sf", "<cmd>lua require('fzf-lua').files()<CR>"},
      {"sa", "<cmd>lua require('fzf-lua').grep_project()<CR>"},
    },
    config = function()
      require('fzf-lua').setup {
       winopts = {
          win_height       = 0.4,            -- ウィンドウの高さ
          win_width        = 1.0,            -- ウィンドウの幅
          win_row          = 1.0,            -- ウィンドウの位置（上からの割合）
          win_col          = 0.5,            -- ウィンドウの位置（左からの割合）
          hl_normal        = 'Normal',       -- リストの通常のハイライトグループ
          hl_border        = 'FloatBorder',  -- ウィンドウの境界線のハイライトグループ
          -- ウィンドウにカーソルを合わせてリストを開く
          preview_opts = 'hidden,nowrap',
          preview_vertical = 'down:45%',
          preview_horizontal = 'right:30%',
          preview_border = 'border',
          preview_wrap = 'nowrap',
        }
      }
    end
  },
  {
    "terrortylor/nvim-comment", -- gccでコメントアウトトグル
    config = function()
      require('nvim_comment').setup()
    end
  },
  {
    "windwp/nvim-autopairs", -- 自動括弧補完
    config = function()
      require("nvim-autopairs").setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim", -- ステータスライン
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "powerline_dark"
        }
      }
    end
  },
  {
    "lewis6991/gitsigns.nvim", -- 画面右側にgitの状態出す
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "kylechui/nvim-surround", -- 括弧をコマンドでくくる
    config = function()
      require('nvim-surround').setup()
    end
  },
  {
    "windwp/nvim-ts-autotag", -- HTMLタグ補完
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    "Shougo/defx.nvim",
    dependencies = { 'kristijanhusak/defx-icons' },
    config = function()
      vim.keymap.set('n', 'si', [[:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>]], {noremap = true, silent = true})
    end
  }
})
