{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-text-editor
    gnome-console
    gnome-user-docs
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-terminal
    gnome-calendar
    gnome-system-monitor
    gnome-calculator
    yelp
    simple-scan
    epiphany
    geary
    evince
    totem
    file-roller
    seahorse
    gnome-music
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-logs
    gnome-weather
    gnome-characters
  ]);
}
