{ pkgs, ... }:

{
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
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-logs
    gnome-weather
    gnome-characters
  ]);
}
