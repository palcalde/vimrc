require'lspconfig'.gopls.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
-- IDE
buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', '<C-W>]', '<C-W>v<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', ',i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', ',c', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
buf_set_keymap('n', ',gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', ',sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', ',se', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap('n', ',R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- LSP
buf_set_keymap('n', ',li', '<cmd>LspInfo<CR>', opts)
buf_set_keymap('n', ',lr', '<cmd>LspStart<CR>', opts)
buf_set_keymap('n', ',ls', '<cmd>LspStop<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Format on save
vim.api.nvim_command[[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]

-- disable publishDiagnostics, I use ALE instead

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = false,
  update_in_insert = false,
  }
)