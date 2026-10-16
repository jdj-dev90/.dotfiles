local function augroup(name)
  return vim.api.nvim_create_augroup("jordan" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_cmds"),
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end
    bufmap("n", "K", vim.lsp.buf.hover)
    bufmap("n", "gd", vim.lsp.buf.definition)
    bufmap("n", "gD", vim.lsp.buf.declaration)
    bufmap("n", "gi", vim.lsp.buf.implementation)
    bufmap("n", "go", vim.lsp.buf.type_definition)
    bufmap("n", "gr", vim.lsp.buf.references)
    bufmap("n", "gs", vim.lsp.buf.signature_help)
    bufmap("n", "<F2>", vim.lsp.buf.rename)
    bufmap({ "n", "x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end)
    bufmap("n", "<F4>", vim.lsp.buf.code_action)
    bufmap("x", "<F4>", function()
      vim.lsp.buf.code_action()
    end)
    bufmap("n", "gl", vim.diagnostic.open_float)
    bufmap("n", "[d", vim.diagnostic.goto_prev)
    bufmap("n", "]d", vim.diagnostic.goto_next)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.api.nvim_cmd({ cmd = "checktime" }, {})
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.api.nvim_cmd({ cmd = "tabdo", args = { "wincmd", "=" } }, {})
    vim.api.nvim_cmd({ cmd = "tabnext", args = { tostring(current_tab) } }, {})
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(0, false)
    end, { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Set line number on mode switch
vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup("set_line_number_on_mode_switch"),
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("set_line_number_on_mode_switch"),
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Dadbod completion
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("dadbod_completion"),
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
  pattern = "*.tmpl",
  callback = function(ev)
    vim.bo[ev.buf].filetype = "gotmpl"
  end,
})

-- Also catch by filetype detection
vim.filetype.add({
  extension = {
    tmpl = "gotmpl",
    -- project.godot, .tscn/.tres are already detected as gdresource by nvim
    -- core; .import files use the same ini-like format but aren't covered.
    import = "gdresource",
  },
  filename = {
    ["project.godot"] = "gdresource",
  },
})

-- hclStringInterp uses `contains=ALLBUT` which causes O(n²) syntax parsing
-- inside heredocs. Redefine both regions without recursive containment.
vim.api.nvim_create_autocmd("Syntax", {
  group = augroup("hcl_fix_heredoc_perf"),
  -- terraform's syntax file doesn't define these groups, so only hcl applies
  pattern = { "hcl" },
  callback = function()
    vim.cmd([[
      syn clear hclStringInterp
      syn region hclStringInterp matchgroup=hclBraces start=/\(^\|[^$]\)\$\zs{/ end=/}/ contained
      syn clear hclHereDocText
      syn region hclHereDocText start=/<<-\?\z([a-z0-9A-Z]\+\)/ end=/^\s*\z1/
      hi def link hclHereDocText String
    ]])
  end,
})

-- Disabled: No good formatter for Go templates that generate JSON
-- djlint is designed for HTML templates and removes indentation
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup("format_gotmpl_on_save"),
--   pattern = { "*.tmpl" },
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     ---[[Code required to activate autocompletion and trigger it on each keypress
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
--     vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.completion.get()
--       end
--     })
--     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--     ---]]
--
--     ---[[Code required to add documentation popup for an item
--     local _, cancel_prev = nil, function() end
--     vim.api.nvim_create_autocmd('CompleteChanged', {
--       buffer = args.buf,
--       callback = function()
--         cancel_prev()
--         local info = vim.fn.complete_info({ 'selected' })
--         local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
--         if nil == completionItem then
--           return
--         end
--         _, cancel_prev = vim.lsp.buf_request(args.buf,
--           vim.lsp.protocol.Methods.completionItem_resolve,
--           completionItem,
--           function(err, item, ctx)
--             if not item then
--               return
--             end
--             local docs = (item.documentation or {}).value
--             local win = vim.api.nvim__complete_set(info['selected'], { info = docs })
--             if win.winid and vim.api.nvim_win_is_valid(win.winid) then
--               vim.treesitter.start(win.bufnr, 'markdown')
--               vim.wo[win.winid].conceallevel = 3
--             end
--           end)
--       end
--     })
--     ---]]
--   end
-- })
