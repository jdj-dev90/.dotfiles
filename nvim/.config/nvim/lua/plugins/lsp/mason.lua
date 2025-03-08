return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      require("mason-lspconfig").setup_handlers({
        function(server)
          lspconfig[server].setup({})
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            root_dir = util.root_pattern(".git"),
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    "vim",
                    "luaList", -- KrakenD
                    "luaTable", -- KrakenD
                    "http_response", -- KrakenD
                    "custom_error", -- KrakenD
                    "json", -- KrakenD
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
          lspconfig.gopls.setup({
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
            filetypes = { "go", "gomod", "gotmpl" }, -- Include gotmpl filetype
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
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
        ["pyright"] = function()
          lspconfig.pyright.setup({})
        end,
      })
    end,
  },
}
