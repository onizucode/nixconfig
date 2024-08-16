{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.nautilus
    dunst
    libnotify
    wofi
    waybar
    networkmanagerapplet
    polkit-kde-agent
  ];

  security.rtkit.enable = true;
  security.polkit.enable = true;

}
