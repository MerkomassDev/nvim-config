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

-- Configure servers

require('mason-lspconfig').setup_handlers({
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
