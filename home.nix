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

  nixpkgs.overlays = [ inputs.zig.overlays.default ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnumake
    clang
    lldb
    clang-tools
    onefetch
    fastfetch
    cpufetch
    zigpkgs.master
    unstable.ncdu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/kitty/kitty.conf".source = dotfiles/kitty/kitty.conf;
    ".config/kitty/theme.conf".source = dotfiles/kitty/oceanspace.conf;
    ".config/ncdu/config".source = dotfiles/ncdu;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "mikastiv@outlook.com";
      userName = "mikastiv";
      extraConfig = {
        init = {
	  defaultBranch = "main";
	};
      };
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    firefox.enable = true;

    lazygit.enable = true;

    htop.enable = true;

    btop.enable = true;

    bat.enable = true;

    ripgrep.enable = true;

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
