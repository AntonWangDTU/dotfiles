-- Read persisted theme or fall back to default
local theme_file = vim.fn.stdpath("config") .. "/.theme"
local default_theme = "tokyonight-night"
local active_theme = default_theme
do
  local f = io.open(theme_file, "r")
  if f then
    local scheme = f:read("*l")
    f:close()
    if scheme and scheme ~= "" then
      active_theme = scheme
    end
  end
end

return {
  -- Color schemes
  { "ellisonleao/gruvbox.nvim" },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/everforest" },
  { "bluz71/vim-nightfly-colors" },
  { "NLKNguyen/papercolor-theme" },
  { "romainl/Apprentice" },
  { "Mofiqul/vscode.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
  },
  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = active_theme,
    },
  },
}
