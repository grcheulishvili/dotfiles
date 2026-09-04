-------------------------------------------------------------------------------
-- 1. PERFORMANCE & CORE
-------------------------------------------------------------------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.shada = ""
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.synmaxcol = 500

-------------------------------------------------------------------------------
-- 2. UI, DISPLAY & ENGAGEMENT TARGET
-------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.ruler = false

-- Render Active Engagement Target in Statusline across Windows and Linux
local target = vim.env.TARGET
if target and target ~= "" then
    vim.opt.statusline = "%#ErrorMsg# [TARGET: " .. target .. "] %*"
    vim.opt.laststatus = 2
end

-------------------------------------------------------------------------------
-- 3. CROSS-PLATFORM SHELL INTEROP
-------------------------------------------------------------------------------
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

if is_windows then
    if vim.fn.executable("pwsh") == 1 then
        vim.opt.shell = "pwsh"
    else
        vim.opt.shell = "powershell"
    end
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
else
    vim.opt.shell = "/bin/bash"
end

-------------------------------------------------------------------------------
-- 4. SYNTAX, THEME & TRANSPARENCY
-------------------------------------------------------------------------------
vim.opt.syntax = "on"
vim.cmd("filetype plugin indent on")

-- Apply color scheme safely
pcall(vim.cmd, "colorscheme habamax")

-- Treesitter highlighting fallback
local ok, ts_config = pcall(require, "nvim-treesitter.configs")
if ok then
    ts_config.setup({
        highlight = { enable = true },
        indent = { enable = true },
    })
end

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "#EBDBB2" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

-------------------------------------------------------------------------------
-- 5. NATIVE LSP & AUTO-FORMATTING
-------------------------------------------------------------------------------
local servers = { "gopls", "pyright" }
for _, lsp in ipairs(servers) do
    if vim.fn.executable(lsp) == 1 then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { lsp == "gopls" and "go" or "python" },
            callback = function(args)
                vim.lsp.start({
                    name = lsp,
                    cmd = { lsp },
                    root_dir = vim.fs.root(args.buf, { ".git", "go.mod", "pyproject.toml", "setup.py" }),
                })
            end,
        })
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.py" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-------------------------------------------------------------------------------
-- 6. KEYMAPS & NAVIGATION
-------------------------------------------------------------------------------
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>")

-- File Explorer (Netrw)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { silent = true })

-- LSP Mappings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Visual Block Movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Search Highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")