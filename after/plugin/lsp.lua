local lspconfig = require('lspconfig')

-- Attach function for keybinds and capabilities
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- Keymaps for LSP
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

-- Add capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Check if mason-lspconfig is available and has setup_handlers
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if mason_lspconfig_ok and mason_lspconfig.setup_handlers then
    -- Configure servers using mason-lspconfig handlers
    mason_lspconfig.setup_handlers({
        function(server_name) -- Default handler for all servers
            lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,

        -- Special configuration for lua_ls
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Tell the LSP that `vim` is a global
                        },
                    },
                },
            })
        end,
    })
else
    -- Fallback: manually configure common servers if mason-lspconfig isn't working
    local servers = { 'lua_ls', 'pyright', 'ts_ls', 'clangd' }  -- Changed tsserver to ts_ls
    for _, server in ipairs(servers) do
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end
