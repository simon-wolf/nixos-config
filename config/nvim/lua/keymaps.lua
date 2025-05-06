vim.keymap.set('n', '<C-p>', ':FzfLua files<Cr>', { silent = true, desc = "Open fzf" })
vim.keymap.set('n', '-', '<cmd>Oil --float<Cr>', { silent = true, desc = "Open parent directory in Oil" })
