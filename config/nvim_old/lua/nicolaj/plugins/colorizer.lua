return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("colorizer").setup({
            "css",
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            html = { mode = "foreground" },
        })
    end,
}
