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
    'obaland/vfiler.vim', -- ファイラ
    lazy = false,
    dependencies = { "obaland/vfiler-column-devicons" },
    keys = {
      {"si", ":VFiler -find-file<CR>"},
    },
    config = function()
      local action = require('vfiler/action')
      require('vfiler/config').setup {
        options = {
          columns = 'git,indent,devicons,name',
          auto_cd = true,
        },
        mappings = {
          ['o'] = action.open_tree,
          ['l'] = action.open,
          ['<CR>'] = action.open,
        },
      }
      require('vfiler/config').unmap('<Space>')
      require('vfiler/config').unmap('L')
      require('vfiler/config').unmap('s')
      require('vfiler/config').unmap('t')
      -- vim.cmd([[
      --   autocmd VimEnter * if &filetype ==# netrw | echo 'hoge' | endif
      -- ]])
      vim.cmd([[
        autocmd VimEnter * if &filetype ==# '' | execute "VFiler" | endif
      ]])
    end
  },
  {
    "hrsh7th/nvim-cmp", -- 補完
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          -- { name = "buffer" },
          -- { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ['<C-f>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        -- experimental = {
        --   ghost_text = true,
        -- },
      })
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
    "akinsho/bufferline.nvim", -- バッファライン
    version = "v3.*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          separator_style = 'thin',
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
        },
        highlights = {
          background = {
            ctermbg = '14',
            ctermfg = '14'
          },
          tab = {
            ctermbg = '14',
            ctermfg = '14'
          }
        }
      })
    end
  },
})
