-- FzfLua
vim.keymap.set(
    "n",
    "<C-p>",
    "<cmd>FzfLua files<Cr>",
    { silent = true, desc = "Find files in the current working directory" }
)
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<Cr>", { silent = true, desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<Cr>", { silent = true, desc = "[F]ind [G]rep" })
vim.keymap.set(
    "n",
    "<leader>fa",
    "<cmd>FzfLua builtin<Cr>",
    { silent = true, desc = "[F]ind via [a]ll FzfLua search types" }
)
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<Cr>", { silent = true, desc = "[F]ind in Neovim [H]elp" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<Cr>", { silent = true, desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<Cr>", { silent = true, desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<Cr>", { silent = true, desc = "[F]ind current [W]ORD" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<Cr>", { silent = true, desc = "[F]ind [R]esume" })
vim.keymap.set(
    "n",
    "<leader>fo",
    "<cmd>FzfLua oldfiles<Cr>",
    { silent = true, desc = "[F]ind [O]ld Files (last opened)" }
)
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<Cr>", { silent = true, desc = "[<leader> Find buffers" })
vim.keymap.set(
    "n",
    "<leader>/",
    "<cmd>FzfLua lgrep_curbuf<Cr>",
    { silent = true, desc = "[/] Live grep the current buffer" }
)

-- Oil
vim.keymap.set("n", "-", "<cmd>Oil --float<Cr>", { silent = true, desc = "Open parent directory in Oil" })

-- LSP
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { silent = true, desc = "Open Diagnostics in a floating window" })

-- Code Formatting
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format()
end, { silent = true, desc = "Format current buffer" })
