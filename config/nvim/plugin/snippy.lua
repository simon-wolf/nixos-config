# https://github.com/dcampos/nvim-snippy

require('snippy').setup({
    mappings = {
        is = {
            ['<S-Tab>'] = 'expand_or_advance',
            ['<Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})
