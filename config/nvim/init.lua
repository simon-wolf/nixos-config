-- Core settings
require('options')

-- Key remapping
require('keymaps')

-- Disable spellchecking in all but a few file types
require('spell')

-- gitgutter
-- https://github.com/airblade/vim-gitgutter
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

