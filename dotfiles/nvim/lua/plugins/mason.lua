return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "rust-analyzer",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
