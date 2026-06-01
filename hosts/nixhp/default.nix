# ./hosts/nixhp/default.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  # Networking
  networking.hostName = "nixhp";
  networking.networkmanager.enable = true;

  # Hardware Drivers
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libva-vdpau-driver
    libvdpau-va-gl
  ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;

  system.stateVersion = "24.11";
}
