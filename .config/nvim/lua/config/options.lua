-- 基础设置
local opt = vim.opt

-- 行号
opt.number = true
opt.relativenumber = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 分割窗口
opt.splitright = true
opt.splitbelow = true

-- 其他
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menuone,noselect"

-- 编码
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 显示不可见字符
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- 折叠
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
