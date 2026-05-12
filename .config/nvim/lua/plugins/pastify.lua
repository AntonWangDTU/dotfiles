return {
  "TobinPalmer/pastify.nvim",
  cmd = { "Pastify", "PastifyAfter" },
  keys = {
    { "<leader>pi", "<cmd>Pastify<cr>", desc = "Paste image" },
  },
  config = function()
    require("pastify").setup({
      opts = {
        save = "local",
        local_path = "/assets/imgs/",
        default_ft = "markdown",
      },
    })
  end,
}
