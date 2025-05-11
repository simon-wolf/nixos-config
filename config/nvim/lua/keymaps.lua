vim.keymap.set('n', '<C-p>', '<cmd>FzfLua files<Cr>', { silent = true, desc = "Find files in the current working directory" })

vim.keymap.set('n', '<leader><C-p>', '<cmd>FzfLua live_grep<Cr>', { silent = true, desc = "Find by grepping current working directory" })

vim.keymap.set('n', '<leader><C-o>', '<cmd>FzfLua builtin<Cr>', { silent = true, desc = "Find from a list of all FzfLua search types" })

vim.keymap.set('n', '-', '<cmd>Oil --float<Cr>', { silent = true, desc = "Open parent directory in Oil" })
