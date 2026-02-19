-- Path: %LOCALAPPDATA%\nvim\init.lua

-------------------------------------------------------------------------------
-- 1. PURE PERFORMANCE (Zero Backups, No Delays)
-------------------------------------------------------------------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true      -- Undo history persists after closing file
vim.opt.shada = ""           -- Faster startup: skip loading old history junk
vim.opt.updatetime = 50      -- Faster UI updates
vim.opt.timeoutlen = 300     -- Faster key combo response
vim.opt.synmaxcol = 500      -- Prevent freeze on long lines

-------------------------------------------------------------------------------
-- 2. LETHAL UI & WORD WRAP
-------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus" -- Windows Clipboard sync

-- Focused Word Wrap
vim.opt.wrap = true
vim.opt.linebreak = true      -- Don't break words in half
vim.opt.breakindent = true    -- Maintain indent on wrapped lines

-- Hide UI Clutter
vim.opt.laststatus = 0        -- Hide status line for focus
vim.opt.showmode = false      -- Hide "-- INSERT --" text
vim.opt.ruler = false         -- Hide line/column coordinates

-------------------------------------------------------------------------------
-- 3. WINDOWS POWERSHELL OPTIMIZATION
-------------------------------------------------------------------------------
if vim.fn.executable('pwsh') == 1 then
    vim.opt.shell = 'pwsh'
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
else
    vim.opt.shell = 'powershell'
end

-------------------------------------------------------------------------------
-- 4. NATIVE THEME (MATCHES TERMINAL SCHEME)
-------------------------------------------------------------------------------
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.cmd("colorscheme habamax")

-- Transparency: Adopt the Terminal's background and 90% opacity
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "#EBDBB2" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

-------------------------------------------------------------------------------
-- 5. NATIVE LSP & AUTO-FORMATTING (0.11+)
-------------------------------------------------------------------------------
-- Enable LSP binaries if found in Windows PATH
local servers = { "gopls", "pyright" }
for _, lsp in ipairs(servers) do
    if vim.fn.executable(lsp) == 1 then
        vim.lsp.enable(lsp)
    end
end

-- Auto-format Go and Python files on Save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.py" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-------------------------------------------------------------------------------
-- 6. LETHAL KEYMAPS & NAVIGATION
-------------------------------------------------------------------------------
vim.g.mapleader = " "

-- Fast Escape
vim.keymap.set("i", "jk", "<Esc>")

-- File Explorer (Netrw) - Lethal Side Panel
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.keymap.set('n', '<leader>e', ':Lexplore 25<CR>')

-- LSP Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Docs" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })

-- Visual Mode: Move selected blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Clear Search Highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
