-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")

-- Two ways to load snippets from both LuaSnip1 and LuaSnip2
---- Two ways to load snippets from both LuaSnip1 and LuaSnip2
-- 1. Using a table
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

vim.g.vimtex_compiler_latexmk = {
  build_dir = "latex_out", -- Move auxiliary files to 'latex_out' directory
}
-- Go to ~/.config/nvim/lua/user/keymaps.lua (or create it if it doesn't exist)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode with double Esc" })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  command = "silent! !latexmk -pdf -interaction=nonstopmode -silent %",
})
