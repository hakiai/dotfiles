"===== Dein読み込み =====
if !exists('g:vscode')
  if &compatible
    set nocompatible
  endif
  let s:dein_dir = expand('~/.cache/dein')

  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  " dein.vimが存在していない場合はgithubからclone
  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = expand('~/.config/nvim')

    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

    call dein#load_toml(s:toml_dir. '/dein_lazy.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif

  call map(dein#check_clean(), "delete(v:val, 'rf')")

  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
else
  runtime vim-plug.vim
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
endif

"===== 表示設定 =====
set number "番号の表示
set title "編集中ファイル名の表示
set showmatch "括弧入力時に対応する括弧を示す
set list "タブ、空白、改行を可視化
set laststatus=2 "ステータスを表示
"set ruler "カーソル位置を表示
filetype plugin indent on
set synmaxcol=200
set re=0 "シンタックスハイライトするときの正規表現エンジンの切り替え
" set lazyredraw
set ttyfast
syntax enable
syntax sync minlines=100
colorscheme default
" 色味表: XtermColorTable
highlight Search ctermfg=17
highlight PmenuSel ctermbg=123 ctermfg=16
highlight Special ctermfg=87
highlight MatchParen ctermbg=93
highlight CursorColumn ctermbg=91
highlight DiffAdd cterm=bold ctermbg=23
highlight CursorLine cterm=None ctermbg=0
highlight CocFadeOut ctermbg=160
highlight Constant ctermfg=51
highlight Comment ctermfg=31
highlight PreProc ctermfg=46
highlight Visual ctermbg=23
highlight Todo ctermbg=190
highlight CocInlayHint ctermfg=31

"===== 文字、カーソル設定 =====
set fenc=utf-8 "文字コードを指定
set virtualedit=onemore "カーソルを行末の一つ先まで移動可能にする
set expandtab "Tabで空白を挿入
set autoindent "自動インデント
set smartindent "オートインデント
set tabstop=2 "インデントをスペース2つ分に設定
set shiftwidth=2 "自動的に入力されたインデントの空白を2つ分に設定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ "不可視文字の指定
set whichwrap=b,s,h,l,<,>,[,],~ "行頭、行末で行のカーソル移動を可能にする
set backspace=indent,eol,start "バックスペースでの行移動を可能にする
set nocursorline "カーソル行を強調表示しない
" autocmd InsertEnter,InsertLeave * set cursorline! "インサートモード時、行をハイライト
"モードによってカーソルの形を変える
let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"
" let &t_ti.="\e[2 q"
" let &t_SI.="\e[6 q"
" let &t_EI.="\e[2 q"
" let &t_te.="\e[0 q"

set scrolloff=3 "スクロールの余裕を確保する


"===== 検索設定 =====
set ignorecase "大文字、小文字の区別をしない
set smartcase "大文字が含まれている場合は区別する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索した文字を強調
set incsearch "インクリメンタルサーチを有効にする


"===== マウス設定 =====
set mouse=a

"===== キー入力 =====
"共通
let mapleader = "\<Space>"
if !exists('g:vscode')
  noremap j gj
  noremap k gk
else
  nnoremap k <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  nnoremap j <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
endif

"ノーマルモード
noremap <CR> A<CR><ESC>
noremap <C-j> 10j
noremap <C-k> 10k
noremap <C-h> ^
noremap <Backspace> ^
noremap <C-l> $
if !exists('g:vscode')
  nnoremap <silent>ss :split<Return><C-w>w
  nnoremap <silent>sv :vsplit<Return><C-w>w
  noremap sh <C-w>h
  noremap sk <C-w>k
  noremap sj <C-w>j
  noremap sl <C-w>l
  noremap sH <C-w>H
  noremap sK <C-w>K
  noremap sJ <C-w>J
  noremap sL <C-w>L
  nnoremap <silent>st :tabnew<Return>
  nnoremap <silent>th :tabprev<Return>
  nnoremap <silent>tl :tabnext<Return>
  nnoremap <silent>sp :bprev<CR>
  nnoremap <silent>sn :bnext<CR>
endif
" nnoremap ; :
" nnoremap : ;
nnoremap n nzz
nnoremap N Nzz
nnoremap x "_x
nnoremap <silent><Leader>n :noh<CR>
nnoremap <C-f> l
"python3実行
nnoremap <silent><Leader><Leader>p :!python3 %<CR>
set shell=/bin/zsh

"インサートモード
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Delete>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>

" ヴィジュアルモード
vnoremap <C-j> 10j
vnoremap <C-k> 10k
vnoremap <C-h> ^
vnoremap <C-l> $
" vnoremap ; :
" vnoremap : ;


"===== その他 =====
"履歴を10000件保存
set history=10000
set nobackup "バックアップファイルを作らない
set noswapfile "スワップファイルを作らない
set autoread "編集中のファイルが変更されたら自動で読み直す
set hidden "バッファが編集中でもそのほかのファイルを開けるようにする

" ファイルを閉じてもundoできるようファイルを作成
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
  call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

"モード切り替えを早く
set timeout timeoutlen=1000 ttimeoutlen=50

"クリップボード共有
set clipboard=unnamed

" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//e

" markdownでバッククオートを表示する
let g:vim_markdown_conceal = 0

" ====== :SyntaxInfoでハイライトグループを見る ======
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
    \ "name": name,
    \ "ctermfg": ctermfg,
    \ "ctermbg": ctermbg,
    \ "guifg": guifg,
    \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
    \ " ctermfg: " . baseSyn.ctermfg .
    \ " ctermbg: " . baseSyn.ctermbg .
    \ " guifg: " . baseSyn.guifg .
    \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
    \ " ctermfg: " . linkedSyn.ctermfg .
    \ " ctermbg: " . linkedSyn.ctermbg .
    \ " guifg: " . linkedSyn.guifg .
    \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"=======================================================
"
" ファイルタイプtsxを認識させる
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" カレントペイン以外の背景色を変更======================
""フォーカスしていない時の背景色(23を好きな値・色に変更)
"let g:InactiveBackGround = 'ctermbg=0'

""Neovim内でフォーカスしていないペインの背景色設定
"execute ('hi NormalNC '.g:InactiveBackGround)
"execute ('hi NontextNC '.g:InactiveBackGround)
"execute ('hi SpecialkeyNC '.g:InactiveBackGround)
"execute ('hi EndOfBufferNC '.g:InactiveBackGround)

""Neovim自体からフォーカスを外したりした際の切替設定
""(フォーカスした時の設定はcolorschemeに合わせて変更）
"augroup ChangeBackGround
"autocmd!
"" フォーカスした時(colorscheme準拠に切替)
"autocmd FocusGained * hi Normal ctermbg=234 " :hi Normalで取得した値
"autocmd FocusGained * hi NonText ctermbg=234 " :hi NonTextで取得した値
"autocmd FocusGained * hi SpecialKey ctermbg=234 " :hi SpecialKeyで取得した値
"autocmd FocusGained * hi EndOfBuffer ctermbg=0 " EndOfBufferの設定は恐らくclearなのでnoneを入れる
"" フォーカスを外した時（フォーカスしていない時の背景色に切替)
"autocmd FocusLost * execute('hi Normal '.g:InactiveBackGround)
"autocmd FocusLost * execute('hi NonText '.g:InactiveBackGround)
"autocmd FocusLost * execute('hi SpecialKey '.g:InactiveBackGround)
"autocmd FocusLost * execute('hi EndOfBuffer '.g:InactiveBackGround)
"augroup end
" ======================================================
" python path
let g:python_host_prog = expand('~/.pyenv/versions/neovim-2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim-3/bin/python')

" よく使うけど忘れるコマンド
" :call dein#update()   プラグインアップデート
" :call dein#recache_runtimepath()  キャッシュ削除
