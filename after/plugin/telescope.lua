local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--vim.keymap.set("n", "<leader>ps", require("telescope.builtin").live_grep, { noremap = true, silent = true })

-- Project-wide search (default live_grep)
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { noremap = true, silent = true })

-- Search only in the current working directory (folder open in nvim)
vim.keymap.set("n", "<leader>pw", function()
    builtin.live_grep({ search_dirs = {vim.fn.getcwd()} })
end, { noremap = true, silent = true })

-- Search in the current buffer
vim.keymap.set("n", "<leader>pb", builtin.current_buffer_fuzzy_find, { noremap = true, silent = true })
