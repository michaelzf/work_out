-- 自动命令
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 高亮复制的文本
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- 打开文件时恢复光标位置
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
    group = "RestoreCursor",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- 自动创建目录
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
    group = "AutoCreateDir",
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- 关闭某些文件类型时不保存到 buffer 列表
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
    group = "CloseWithQ",
    pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- 自动格式化
augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
    group = "AutoFormat",
    pattern = { "*.lua", "*.py", "*.go", "*.rs" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- 去除行尾空格
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
    group = "TrimWhitespace",
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- 不同文件类型的缩进设置
augroup("FileTypeIndent", { clear = true })
autocmd("FileType", {
    group = "FileTypeIndent",
    pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
