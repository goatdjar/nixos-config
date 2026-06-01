# ./modules/desktop/gnome.nix
{ pkgs, ... }:

{
  # Windowing & Desktop Environments
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Keyboard Layout Matrix
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak-mac";
    options = "ctrl:swapcaps";
  };
  console.useXkbConfig = true;

  # Printing System
  services.printing.enable = true;

  # Multimedia Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
