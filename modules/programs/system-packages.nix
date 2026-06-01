# ./modules/programs/system-packages.nix
{ pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
    ];
  };

  environment.systemPackages = with pkgs; [
    # Browsers / Collaboration
    brave
    firefox-esr-140-unwrapped
    element-desktop
    zoom-us
    webex

    # Editors & Production
    wezterm
    helix
    vscode
    obsidian
    exercism

    # System Libs
    wl-clipboard
    fastfetch
    nix-index
    libGL
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
  ];
}
