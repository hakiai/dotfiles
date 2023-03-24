-- 全般
vim.opt.fenc = "utf-8"
vim.opt.clipboard = "unnamedplus" -- ヤンクでクリップボードを利用
vim.opt.whichwrap = "b,s,[,],<,>" -- 行頭・行末でカーソル移動を可能にする
vim.opt.listchars = {tab="▸ ", eol="↲", extends="❯", precedes="❮"} -- 不可視文字の設定
vim.opt.number = true -- 行番号表示

-- インデント
vim.opt.expandtab = true -- タブでスペースを入れる
vim.opt.smartindent = true -- インデント自動化
vim.opt.tabstop = 2 -- インデントをスペース2にする
vim.opt.shiftwidth = 2 -- タブをスペース2にする

-- 文字入力
vim.opt.backspace = "indent,eol,start" -- バックスペースでの行移動を可能にする
vim.opt.showmatch = true -- 対応する括弧をハイライト
vim.opt.list = true -- 不可視文字を可視化
vim.opt.laststatus = 2 -- ステータス表示

-- 検索周り
vim.opt.ignorecase = true -- 大文字、小文字の区別をしない
vim.opt.smartcase = true -- 大文字が含まれている場合は区別する
vim.opt.wrapscan = true -- 検索時に最後まで行ったら最初に戻る
vim.opt.hlsearch = true -- 検索した文字を強調
vim.opt.incsearch = true -- インクリメンタルサーチを有効にする

vim.opt.undofile = true -- 閉じてもundoできるように
vim.opt.undodir = vim.fn.stdpath('config') .. '/lua/.undo'
