require("lazy").setup({
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {"<Leader>f", "<cmd>lua require('fzf-lua').files()<CR>"},
      {"<Leader>a", "<cmd>lua require('fzf-lua').grep_project()<CR>"},
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
    'obaland/vfiler.vim',
    dependencies = { 'obaland/vfiler-column-devicons' },
    keys = {
      {"<Leader>d", ":VFiler -find-file<CR>"},
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
          ['<CR>'] = function(vfiler, context, view)
            action.toggle_select(vfiler, context, view)
            action.move_cursor_down(vfiler, context, view)
          end,
        },
      }
      require('vfiler/config').unmap('<Space>')
      require('vfiler/config').unmap('L')
    end
  },
})
