# ./modules/users/gdj.nix
{ pkgs, ... }:

{
  # Primary User Profile Context
  users.users.gdj = {
    isNormalUser = true;
    description = "Goat D Jar";
    extraGroups = [
      "users"
      "docker"
      "dialout"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # Virtualization Engines
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # Inject profile into hypervisor runtime access lists
  users.extraGroups.vboxusers.members = [ "gdj" ];
}
