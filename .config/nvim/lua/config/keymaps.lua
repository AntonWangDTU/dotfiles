-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Keybinding setup for LuaSnip
local ls = require("luasnip")

--  -- Keybinding for jumping to the next snippet placeholder
--  vim.keymap.set({ "i", "s" }, "<C-k>", function()
--    if ls.jumpable(1) then
--      ls.jump(1)
--    end
--  end, { silent = true })
--
--  -- Keybinding for jumping back to the previous snippet placeholder
--  vim.keymap.set({ "i", "s" }, "<C-j>", function()
--    if ls.jumpable(-1) then
--      ls.jump(-1)
--    end
--  end, { silent = true })
--
--  -- keymaps for changing snippet
--  vim.keymap.set({ "i" }, "<C-K>", function()
--    ls.expand()
--  end, { silent = true })
--  vim.keymap.set({ "i", "s" }, "<C-L>", function()
--    ls.jump(1)
--  end, { silent = true })
--  vim.keymap.set({ "i", "s" }, "<C-J>", function()
--    ls.jump(-1)
--  end, { silent = true })
--
--  vim.keymap.set({ "i", "s" }, "<C-E>", function()
--    if ls.choice_active() then
--      ls.change_choice(1)
--    end
--  end, { silent = true })

-- Toggle light/dark theme and persist the choice
local _theme_file = vim.fn.stdpath("config") .. "/.theme"
local _dark = "tokyonight-night"
local _light = "github_light"

vim.keymap.set("n", "<leader>tt", function()
  local next = (vim.g.colors_name == _dark) and _light or _dark
  vim.cmd("colorscheme " .. next)
  local f = io.open(_theme_file, "w")
  if f then f:write(next); f:close() end
end, { desc = "Toggle light/dark theme" })

-- navigate within insert mode (with remaps)
vim.keymap.set("i", "<c-h>", "<Left>", { remap = true })
vim.keymap.set("i", "<c-l>", "<Right>", { remap = true })
vim.keymap.set("i", "<c-j>", "<Down>", { remap = true })
vim.keymap.set("i", "<c-k>", "<Up>", { remap = true })
