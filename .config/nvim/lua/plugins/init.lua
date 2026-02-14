-- lazy.nvim 插件管理器配置
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 插件列表
require("lazy").setup({
    -- LSP
    require("plugins.lsp"),
    -- 补全
    require("plugins.cmp"),
    -- 文件搜索
    require("plugins.telescope"),
    -- 语法高亮
    require("plugins.treesitter"),
    -- UI
    require("plugins.ui"),
}, {
    install = {
        colorscheme = { "tokyonight", "habamax" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})
