return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                -- disable = { 'missing-fields' }
                globals = { "vim" },
            },
            runtime = {
                version = "LuaJIT",
            },
        },
    },
}
