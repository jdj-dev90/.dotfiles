return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",
    opts = {
      ensure_installed = { "gopls", "lua_ls" },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers({
        function(server)
          vim.lsp.config(server, {})
        end,
        ["lua_ls"] = function()
          vim.lsp.config('lua_ls', {
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    "vim",
                    "luaList",       -- KrakenD
                    "luaTable",      -- KrakenD
                    "http_response", -- KrakenD
                    "custom_error",  -- KrakenD
                    "json",          -- KrakenD
                  },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                  },
                },
              },
            },
          })
        end,
        ["gopls"] = function()
          vim.lsp.config('gopls', {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                -- Improve completion in templates
                completeUnimported = true,
                usePlaceholders = true,
                -- Better diagnostics
                diagnosticsDelay = "500ms",
              },
            },
            filetypes = { "go", "gomod", "gowork", "gotmpl" }, -- Include gotmpl filetype for Go template support
            -- Make gopls work even without go.mod
            root_markers = { "go.mod", "go.work", ".git" },
            -- Fallback to current directory if no root marker found
            single_file_support = true,
            -- Disable semantic tokens to preserve treesitter highlighting
            on_attach = function(client, bufnr)
              client.server_capabilities.semanticTokensProvider = nil
            end,
          })
          -- Explicitly enable gopls
          vim.lsp.enable('gopls')
        end,
        ["yamlls"] = function()
          vim.lsp.config('yamlls', {
            settings = {
              yaml = {
                validate = true,
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = {
                  -- GitHub Workflows schema for files in .github/workflows/
                  ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] =
                  ".github/workflows/*.{yml,yaml}",

                  -- GCP Workflows schema for workflows outside .github/
                  ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/workflows.json"] =
                  "workflows/*.{yml,yaml}",

                  -- Kustomization schema
                  ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",

                  -- Docker Compose schema
                  ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] =
                  "docker-compose*.{yml,yaml}",
                },
              },
            },
          })
        end,
        ["templ"] = function()
          -- Disabled: templ LSP has a bug that causes crashes on formatting
          -- Using none-ls for formatting instead
          -- Diagnostics/linting for .tmpl files will come from gopls
        end,
      })
    end,
  },
}
