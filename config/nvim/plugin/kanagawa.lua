-- https://github.com/rebelot/kanagawa.nvim

require("kanagawa").setup({
    compile = false,
    -- transparent = true,
    overrides = function(colours)
        -- https://github.com/rebelot/kanagawa.nvim/issues/207
        return {
            ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
            ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
            ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
            ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
            ["@markup.list.markdown"] = { link = "Function" }, -- + list
            ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
        }
    end,
    theme = "wave"
})

vim.cmd("colorscheme kanagawa")

