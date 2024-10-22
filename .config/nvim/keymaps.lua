-- Set leader key to spacebar
vim.g.mapleader = " "

-- Map <leader>y to copy to system clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- Map <leader>p to paste from system clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
