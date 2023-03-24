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
vim.keymap.set('n', '<Leader>n', ':noh<CR>')

-- 文字入力
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '<CR>', 'A<CR><ESC>')

-- ペイン・タブ
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sh', '<C-w>h')
vim.keymap.set('n', 'sj', '<C-w>j')
vim.keymap.set('n', 'sk', '<C-w>k')
vim.keymap.set('n', 'sl', '<C-w>l')
vim.keymap.set('n', 'st', ':tabnew<CR>')
vim.keymap.set('n', 'th', ':tabprev<CR>')
vim.keymap.set('n', 'tl', ':tabnext<CR>')
vim.keymap.set('n', 'sp', ':bprev<CR>')
vim.keymap.set('n', 'sn', ':bnext<CR>')

-- インサートモード
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('i', '<C-d>', '<Delete>')

