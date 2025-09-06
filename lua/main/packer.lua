-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Colorscheme
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    }
    -- CSS color preview
    use 'ap/vim-css-color'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'

    -- Misc tools
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'

    -- Github Copilot
    use 'github/copilot.vim'

    -- LSP Setup
    use 'neovim/nvim-lspconfig' -- Core LSP support
    use 'williamboman/mason.nvim' -- Manage LSP servers, linters, and formatters
    use 'williamboman/mason-lspconfig.nvim' -- Bridge between mason.nvim and nvim-lspconfig
    use {
        'hrsh7th/nvim-cmp', -- Autocompletion framework
        requires = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'hrsh7th/cmp-buffer', -- Buffer completions
            'hrsh7th/cmp-path', -- Path completions
            'saadparwaiz1/cmp_luasnip', -- Snippet completions
            'L3MON4D3/LuaSnip', -- Snippet engine
        }
    }

    -- vimtex
    use {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_method = 'zathura' -- Set your preferred PDF viewer
            vim.g.vimtex_view_forward_search_on_start = false
        end
    }

    -- Optional UI Enhancements for LSP
    use {
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function()
            require('lspsaga').setup({})
        end,
        requires = { {'nvim-tree/nvim-web-devicons'} }
    }
    use {
        'OXY2DEV/markview.nvim',
        config = function()
            require('markview').setup()
        end
    }

end)

