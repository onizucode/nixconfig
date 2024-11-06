return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
