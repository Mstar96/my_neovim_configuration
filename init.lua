-------------------------------------------------
-- Leader
--------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------
-- 基础显示 / 编辑体验
--------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

--------------------------------------------------
-- 语法高亮（兜底 + Tree-sitter）
--------------------------------------------------
vim.cmd("syntax on")

--------------------------------------------------
-- 系统剪贴板（macOS / Linux 通用）
--------------------------------------------------
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------
-- netrw（内置文件管理）
--------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

--------------------------------------------------
-- 窗口切换（普通模式）
--------------------------------------------------
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

--------------------------------------------------
-- 打开终端
--------------------------------------------------
-- 右侧开一个终端（不改 cwd）
vim.keymap.set("n", "<leader>tr", ":vsplit | terminal<CR>", { silent = true })

-- 在“当前文件所在目录”打开终端（推荐）
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("cd %:p:h")
  vim.cmd("vsplit")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { silent = true })

--------------------------------------------------
-- 终端模式下的窗口切换
--------------------------------------------------
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

--------------------------------------------------
-- 终端模式：Esc 回普通模式
--------------------------------------------------
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

--------------------------------------------------
--entering terminal with insert mode
vim.api.nvim_create_autocmd("WinEnter",{
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
        end
    end,
})
--------------------------------------------------
-- Buffer 管理
--------------------------------------------------
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })

--------------------------------------------------
-- 关闭当前窗口 / 终端（⚠️ 不直接 exit nvim）
--------------------------------------------------
vim.keymap.set("n", "<leader>x", ":close<CR>", { silent = true })

--------------------------------------------------
-- Tab 管理
--------------------------------------------------
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { silent = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>th", ":tabprev<CR>", { silent = true })

--------------------------------------------------
-- netrw 快捷打开
--------------------------------------------------
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { silent = true })

--------------------------------------------------
-- lazy.nvim
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- Tree-sitter（稳定白名单）
--------------------------------------------------
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end

      configs.setup({
        ensure_installed = {
          "python",
          "c",
          "cpp",
          "java",
          "javascript",
          "rust",
          "go",
          "lua",
          "bash",
          "json",
          "yaml",
          "markdown",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "latex" },
        },
      })
    end,
  },
})

