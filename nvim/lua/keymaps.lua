-- Leaderをスペースに変更
vim.g.mapleader = " "

-- 移動
vim.keymap.set({'n', 'v'}, '<C-j>', '10j')
vim.keymap.set({'n', 'v'}, '<C-k>', '10k')
vim.keymap.set({'n', 'v'}, '<C-h>', '^')
vim.keymap.set({'n', 'v'}, '<Backspace>', '^')
vim.keymap.set({'n', 'v'}, '<C-l>', '$')
vim.keymap.set('n', '<C-f>', 'l')

-- 検索
vim.keymap.set('n', '<silent><Leader>n', ':noh<CR>')

-- 文字入力
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '<CR>', 'A<CR><ESC>')

-- ペイン・タブ
vim.keymap.set('n', '<Leader>H', ':vsplit<Return>')
vim.keymap.set('n', '<Leader>J', ':split<Return><C-w>w')
vim.keymap.set('n', '<Leader>K', ':split<Return>')
vim.keymap.set('n', '<Leader>L', ':vsplit<Return><C-w>w')
vim.keymap.set('n', '<Leader>h', '<C-w>h')
vim.keymap.set('n', '<Leader>j', '<C-w>j')
vim.keymap.set('n', '<Leader>k', '<C-w>k')
vim.keymap.set('n', '<Leader>l', '<C-w>l')
vim.keymap.set('n', '<Leader>l', '<C-w>l')

-- インサートモード
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('i', '<C-d>', '<Delete>')

