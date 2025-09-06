vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste and Yank from clipboard
vim.keymap.set('n', '<leader>p', '"+p', opts)
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', opts)
