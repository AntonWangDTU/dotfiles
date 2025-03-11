return {
  -- See: https://github.com/microsoft/pyright/blob/main/docs/settings.md
  require("lspconfig")["pyright"].setup({
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          autoImportCompletions = false,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          stubPath = "/home/jsr-p/typings/",
          -- typeCheckingMode = "off",
          -- logLevel = "Trace",
        },
      },
    },
  }),
}
