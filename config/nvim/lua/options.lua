-- Show line numbers and make them relative
vim.opt.number = true
vim.opt.relativenumber = true

-- The mode is shown via lua-line so Neovim does not need to show it
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default. This is the column that shows things like Git changes.
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 100

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Tabs, Spaces and Indenting
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces used for indenting
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.softtabstop = 4 -- Number of spaces when pressing Tab
vim.opt.smarttab = true -- Delete <tabstop> spaces in one since it is considered a tab
vim.opt.smartindent = true -- Indent a new line based on the previous line
vim.opt.autoindent = true -- Keep indentation from previous line
vim.opt.breakindent = true -- If an indented line wraps then it is all indented to the same level

-- Highlight the line where the cursor is
vim.opt.cursorline = true

-- By default, open files with all folds open
vim.opt.foldenable = false

-- Set the conceal level to zero (the default) to override Treesitter setting it to 2 which hides link.
-- vim.opt.conceallevel = 0
vim.g.vimwiki_conceallevel = 0

-- Show comments in italic
vim.cmd[[highlight Comment cterm=italic gui=italic]]

-- Show some whitespace characters
-- list enables list mode which shows the characters.
-- listchars is used to define custom characters to show.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- When possible, show some lines above and below the cursor to provide some context
vim.opt.scrolloff = 5

-- Disable the commandline until it is needed which gives a cleaner look and an extra line
vim.opt.cmdheight = 0

