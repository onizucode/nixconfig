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

  # Enable Gnome package
  environment.systemPackages = with pkgs;[
    gnome-tweaks
    gnomeExtensions.battery-health-charging
    gnomeExtensions.vitals

  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    cheese
    epiphany
    evince
    file-roller
    geary
    gedit
    gnome-tour
    gnome-connections
    gnome-text-editor
    gnome-console
    gnome-user-docs
    gnome-terminal
    gnome-calendar
    gnome-system-monitor
    gnome-calculator
    gnome-music
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-logs
    gnome-weather
    gnome-characters
    seahorse
    simple-scan
    totem
    yelp
  ]);
}
