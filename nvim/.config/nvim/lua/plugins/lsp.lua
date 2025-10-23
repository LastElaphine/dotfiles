return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          root_dir = function(bufnr, ondir)
            if vim.fs.root(bufnr, { "package.json" }) ~= nil then
              ondir(vim.fs.root(bufnr, { "package.json" }))
            end
          end,
        },
      },
    },
  },
}

