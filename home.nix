{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mikastiv";
  home.homeDirectory = "/home/mikastiv";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    brave
    discord
    gnumake
    clang
    lldb
    clang-tools
    onefetch
    cpufetch
    valgrind
    wl-clipboard
    zigpkgs.master
    unstable.ncdu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/kitty/kitty.conf".source = dotfiles/kitty/kitty.conf;
    ".config/kitty/theme.conf".source = dotfiles/kitty/neowave.conf;
    ".config/ncdu/config".source = dotfiles/ncdu;
    ".config/lazygit/config.yml".source = dotfiles/lazygit.yml;
    ".config/wezterm/wezterm.lua".source = dotfiles/wezterm/wezterm.lua;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    firefox.enable = true;
    lazygit.enable = true;
    htop.enable = true;
    btop.enable = true;
    bat.enable = true;
    ripgrep.enable = true;
    fastfetch.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      package = pkgs.unstable.neovim-unwrapped;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "mikastiv@outlook.com";
      userName = "mikastiv";
      extraConfig = {
        init.defaultBranch = "main";
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingKey = "~/.ssh/id_ed25519_sign.pub";
      };
    };

    eza = {
      enable = true;
      icons = true;
      git = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        ls = "eza";
        l = "eza -lab";
        cat = "bat";
      };
    };
  };

  
  #stdenv.mkDerivation rec {
  #  pname = "zig";
  #  version = "0.14.0-dev.850";

  #  src = fetchzip {
  #    url = "https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.850+ddcb7b1c1.tar.xz";
  #    sha256 = "sha256-6333iuBvde+eF1KTHrrD1ZW+DwXecjBlb7RR6Ccns3Q=";
  #  };

  #  unpackPhase = "true";

  #  installPhase = ''
  #    mkdir -p $out/bin/zig
  #    cp -r $src/* $out/bin/zig
  #    chmod +x $out/bin/zig/zig
  #  '';

  #  installCheckPhase = ''
  #    $out/bin/zig/zig version
  #  '';
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
