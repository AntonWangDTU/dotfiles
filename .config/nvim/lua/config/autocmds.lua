-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Sync theme across all instances: reload from file when window gains focus
local _theme_file = vim.fn.stdpath("config") .. "/.theme"
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    local f = io.open(_theme_file, "r")
    if f then
      local scheme = f:read("*l")
      f:close()
      if scheme and scheme ~= "" and scheme ~= vim.g.colors_name then
        vim.cmd("colorscheme " .. scheme)
      end
    end
  end,
})
