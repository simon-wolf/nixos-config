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
-- This function gets run when an LSP attaches to a particular buffer.
-- That is to say, every time a new file is opened that is associated with
-- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
-- function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map("gra", require("fzf-lua").lsp_code_actions, "[G]oto Code [A]ctions", { "n", "x" })

        -- Find references for the word under your cursor.
        map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("grd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("gO", require("fzf-lua").lsp_document_symbols, "Open Document Symbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("gW", require("fzf-lua").lsp_live_workspace_symbols, "Open Workspace Symbols")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight") then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method("textDocument/inlayHint") then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

--vim.keymap.set("n", "grn", function()
--    vim.lsp.buf.rename()
--end, { silent = true, buffer = event.buf(), desc = "LSP [R]e[n]ame" })

vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { silent = true, desc = "Open Diagnostics in a floating window" })

-- Code Formatting
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format()
end, { silent = true, desc = "Format current buffer" })

-- Open links
vim.keymap.set("n", "<leader>gx", function()
    vim.api.nvim_feedkeys("0f(gx", "t", false)
end, { silent = tue, desc = "Open first link in line" })
