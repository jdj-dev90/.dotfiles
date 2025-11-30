return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      return {
        sources = {
          -- null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "html", "javascript", "typescript", "css", "json", "yaml", "markdown", "graphql" },
          }),
          null_ls.builtins.diagnostics.golangci_lint.with({
            filetypes = { "go" },
          }),
          null_ls.builtins.formatting.gofumpt.with({
            filetypes = { "go", "gomod" },
          }),
          -- Note: No effective linting/formatting for Go text/template files that generate JSON
          -- djlint only works well for HTML templates
          -- go-template-lint requires Go source files for context
          -- Manual formatting is the recommended approach for these files
          -- null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.formatting.black,
          -- require("none-ls.diagnostics.eslint_d"),

-- null_ls.builtins.diagnostics.eslint_d.with({
--   filetypes = { "javascript", "typescript" },
-- })
        },
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --   group = augroup,
            --   buffer = bufnr,
            --   callback = function()
            --     vim.lsp.buf.format({ bufnr = bufnr })
            --   end,
            -- })
          end
        end,
      }
    end,
  },
}
