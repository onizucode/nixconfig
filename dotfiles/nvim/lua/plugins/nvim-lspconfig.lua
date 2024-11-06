local home_dir = os.getenv("HOME")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        zls = {
          cmd = { home_dir .. "/.zls/zig-out/bin/zls" },
          settings = {
            enable_autofix = true,
          },
        },
      },
    },
  },
}
