-- 快捷键配置
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader 键
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- 保存和退出
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- 窗口导航
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 窗口大小调整
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer 导航
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- 移动选中的行
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 保持视觉模式下的缩进
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 清除搜索高亮
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Telescope (文件搜索) - 保留 Ctrl+E 习惯
keymap("n", "<C-e>", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)
keymap("n", "<leader>o", "<cmd>Neotree focus<CR>", opts)

-- 注释 (Comment.nvim) - 保留 \cc \cu 习惯
keymap("n", "<leader>cc", "gcc", { remap = true })
keymap("v", "<leader>cc", "gc", { remap = true })
keymap("n", "<leader>cu", "gcc", { remap = true })
keymap("v", "<leader>cu", "gc", { remap = true })

-- 代码对齐 - F8
keymap("n", "<F8>", "gg=G<C-o>", opts)
keymap("v", "<F8>", "=", opts)

-- LSP 快捷键 (在 lsp.lua 中会覆盖)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

-- 诊断
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

-- 终端模式
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

-- 快速跳转到行首/行尾
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
