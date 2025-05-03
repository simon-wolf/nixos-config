vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.foldenable = false

-- Show comments in italic
vim.cmd[[highlight Comment cterm=italic gui=italic]]

-- https://github.com/ibhagwan/fzf-lua
-- Remap Ctrl+p to launch the files view 
vim.api.nvim_set_keymap('n', '<C-p>', ':FzfLua files<Cr>', { noremap = true, silent = true })

-- Disable spellchecking in all but a few file types
require('spell')

-- gitgutter
-- https://github.com/airblade/vim-gitgutter
vim.opt.updatetime = 100
vim.cmd[[highlight GitGutterAdd guifg=#009900 ctermfg=Green]]
vim.cmd[[highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow]]
vim.cmd[[highlight GitGutterDelete guifg=#ff2222 ctermfg=Red]]
-- nmap ) <Plug>(GitGutterNextHunk)
-- nmap ( <Plug>(GitHuggerPrevHunk)
-- let g:gitgutter_enabled = 1
-- let gitgutter_map_keys = 0
-- " let g:airline_theme = 'codedark'

-- vimwiki
require('vimwiki')

