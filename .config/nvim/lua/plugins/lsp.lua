return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off", -- Disable strict type checking
              diagnosticSeverityOverrides = {
                reportGeneralTypeIssues = "none",
                reportOptionalSubscript = "none",
                reportOptionalMemberAccess = "none",
                reportUnusedVariable = "none",
              },
            },
          },
        },
      },
    },
  },
}
