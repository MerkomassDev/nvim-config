require("mason").setup()

require("mason-lspconfig").setup({
    -- Do NOT auto-install servers
    automatic_installation = false,
})

local lspconfig = require('lspconfig')

-- Function to ask before installing a server
local function ensure_server_installed(server_name)
    local installed_servers = require("mason-lspconfig").get_installed_servers()
    if not vim.tbl_contains(installed_servers, server_name) then
        vim.ui.input({ prompt = "Install LSP server for " .. server_name .. "? (y/n): " }, function(input)
            if input == "y" or input == "Y" then
                vim.cmd("MasonInstall " .. server_name)
            end
        end)
    end
end

-- Add this handler to only configure servers after user confirmation
require("mason-lspconfig").setup_handlers({
    function(server_name) -- Default handler
        ensure_server_installed(server_name) -- Prompt for installation
        lspconfig[server_name].setup({
            -- Standard LSP configuration
            on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            end,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
    end,
})

