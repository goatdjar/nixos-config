# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 1. Enable the kernel module
  # boot.kernelModules = [ "v4l2loopback" ];

  # 2. Add the package to extraModulePackages
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "nixhp"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  #time.timeZone = "Europe/Paris";
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "it_IT.UTF-8";
  #   LC_IDENTIFICATION = "it_IT.UTF-8";
  #   LC_MEASUREMENT = "it_IT.UTF-8";
  #   LC_MONETARY = "it_IT.UTF-8";
  #   LC_NAME = "it_IT.UTF-8";
  #   LC_NUMERIC = "it_IT.UTF-8";
  #   LC_PAPER = "it_IT.UTF-8";
  #   LC_TELEPHONE = "it_IT.UTF-8";
  #   LC_TIME = "it_IT.UTF-8";
  # };

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "fr_FR.UTF-8";
  #   LC_IDENTIFICATION = "fr_FR.UTF-8";
  #   LC_MEASUREMENT = "fr_FR.UTF-8";
  #   LC_MONETARY = "fr_FR.UTF-8";
  #   LC_NAME = "fr_FR.UTF-8";
  #   LC_NUMERIC = "fr_FR.UTF-8";
  #   LC_PAPER = "fr_FR.UTF-8";
  #   LC_TELEPHONE = "fr_FR.UTF-8";
  #   LC_TIME = "fr_FR.UTF-8";
  # };

  # Add extra fallback locales if needed (e.g., if you want English system messages but Finnish currency/time formats)
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # Update 257.3 to 257.6
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Ensure Dconf is enabled globally
  # This is for global kb config
  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "dvorak-mac";
      options = "ctrl:swapcaps";
    };
  };

  # Keep the regular TTY consoles in sync with my settings
  console.useXkbConfig = true;
  # then do a rebuild and
  # gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
  # on your terminal

  # services.xserver.xkb.extraLayouts.custom = {
  #   description = "My custom layout";
  #   languages = [ "fi" ];
  #   symbolsFile = ~/Downloads/custom_xkb_layouts/arkkudvorak.x86.xmodmap;
  # };

  # services.xserver.xkb.extraLayouts.arkkudvorak = {
  #   description = "ArkkuDvorak Finnish Layout";
  #   languages = [ "fi" ];
  #   # The actual layout file definition
  #   definition = ''
  #     partial alphanumeric_keys
  #     xkb_symbols "basic" {
  #       include "us (dvorak)"
  #       name[Group1]= "Finnish (ArkkuDvorak)";
  #     ! A Dvorak layout for Finnish/Swedish keyboards, by Kimmo Kulovesi.
  #     ! http://arkku.com/dvorak
  #     !
  #     ! Load with xmodmap, e.g., "xmodmap arkkudvorak.xmodmap".
  #     !
  #     ! If you get errors for unrecognized symbols, simply delete those words
  #     ! from this file, then try again. Not all X11 implementations support
  #     ! all the same symbols. If the layout loads but the mappings are
  #     ! incorrect (i.e. not as they should be for Dvorak), your platform has
  #     ! incompatible keycodes. Restore your original layout (e.g., with setxkbmap)
  #     ! and use "xmodmap -pke" to find out what your keycodes are, then modify
  #     ! the codes in this file accordingly.
  #     !
  #     ! Before trying this layout for the first time, it is a good idea to
  #     ! set up your system with a command to switch back to the previous
  #     ! layout aymatically in case something goes wrong. For example, you could
  #     ! run "sleep 60 && setxkbmap fi" to revert after 60 seconds.
  #     !
  #     ! On many systems renaming this file ~/.Xmodmap causes it to auto-load
  #     ! on X11 login.
  #     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  #     keycode  49 = grave             asciitilde          dead_tilde              dead_caron

  #     keycode  10 = 1                 exclam              onesuperior             exclamdown
  #     keycode  11 = 2                 at                  twosuperior             enfilledcircbullet
  #     keycode  12 = 3                 numbersign          threesuperior           sterling
  #     keycode  13 = 4                 dollar              EuroSign                onequarter
  #     keycode  14 = 5                 percent             onehalf                 threequarters
  #     keycode  15 = 6                 asciicircum         dead_circumflex         radical
  #     keycode  16 = 7                 ampersand           paragraph               section
  #     keycode  17 = 8                 asterisk            infinity                multiply
  #     keycode  18 = 9                 parenleft           dagger                  U2248
  #     keycode  19 = 0                 parenright          degree                  notequal
  #     keycode  20 = bracketleft       braceleft           lessthanequal           seconds
  #     keycode  21 = bracketright      braceright          greaterthanequal        minutes

  #     keycode  24 = apostrophe        quotedbl            leftdoublequotemark     leftsinglequotemark
  #     keycode  25 = comma             less                rightdoublequotemark    rightsinglequotemark
  #     keycode  26 = period            greater             ellipsis                periodcentered
  #     keycode  27 = p                 P                   Greek_pi                Greek_PI
  #     keycode  28 = y                 Y                   Greek_psi               Greek_PSI
  #     keycode  29 = f                 F                   function                Greek_PHI
  #     keycode  30 = g                 G                   Greek_gamma             Greek_GAMMA
  #     keycode  31 = c                 C                   ccedilla                Ccedilla
  #     keycode  32 = r                 R                   registered              copyright
  #     keycode  33 = l                 L                   Greek_lambda            Greek_LAMBDA
  #     keycode  34 = slash             question            dead_acute              questiondown
  #     keycode  35 = equal             plus                dead_grave              plusminus

  #     keycode  38 = a                 A                   Adiaeresis              acircumflex
  #     keycode  39 = o                 O                   Odiaeresis              oslash
  #     keycode  40 = e                 E                   egrave                  eacute
  #     keycode  41 = u                 U                   udiaeresis              Udiaeresis
  #     keycode  42 = i                 I                   ae                      oe
  #     keycode  43 = d                 D                   Greek_delta             Greek_DELTA
  #     keycode  44 = h                 H                   hcircumflex             heart
  #     keycode  45 = t                 T                   trademark               U03D1
  #     keycode  46 = n                 N                   ntilde                  Ntilde
  #     keycode  47 = s                 S                   scaron                  scircumflex
  #     keycode  48 = minus             underscore          endash                  emdash
  #     keycode  51 = backslash         bar                 guillemotright          dead_macron

  #     keycode  94 = adiaeresis        odiaeresis          aring                   Aring
  #     keycode  52 = semicolon         colon               dead_diaeresis          U2200
  #     keycode  53 = q                 Q                   Greek_omega             Greek_OMEGA
  #     keycode  54 = j                 J                   Greek_epsilon           U2203
  #     keycode  55 = k                 K                   Greek_chi               Greek_kappa
  #     keycode  56 = x                 X                   Greek_xi                Greek_XI
  #     keycode  57 = b                 B                   ssharp                  Greek_beta
  #     keycode  58 = m                 M                   mu                      Greek_MU
  #     keycode  59 = w                 W                   ubreve                  Ubreve
  #     keycode  60 = v                 V                   Greek_alpha             rightarrow
  #     keycode  61 = z                 Z                   Greek_sigma             Greek_SIGMA

  #     keycode  65 = space             space               nobreakspace            enspace

  #     ! Uncomment only one of the lines below if Alt Gr does not work;
  #     ! either try them one by one or use "xev" to find out the keycode.
  #     ! Remove the ! from the one line you wish to activate:
  #     !keycode 108 = Mode_switch
  #     !keycode 64 = Mode_switch
  #     !keycode 113 = Mode_switch
  #     };
  #   '';
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # User Land ----------------

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
    packages = [
      #  thunderbird
    ];

    shell = pkgs.zsh;
  };

  # Nix to build docker files = better.
  virtualisation.docker.enable = true;
  # Enable vbox
  virtualisation.virtualbox.host.enable = true;
  # Add your user to the vboxusers group
  users.extraGroups.vboxusers.members = [ "gdj" ];

  # (Optional) Enable Extension Pack (for USB 2.0/3.0, RDP, etc.)
  # Note: Requires nixpkgs.config.allowUnfree = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User config starts here
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Expose library path for dependency issues; err numpy for example
  # environment = {
  #   sessionVariables = {
  #     LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
  #   };
  # };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    #
    #
    # Will have to modularize these later
    # stdenv.cc.cc.lib

    # Azure Cloud
    (azure-cli.withExtensions [
      azure-cli.extensions.aks-preview
    ])
    #browser
    brave
    firefox-esr-140-unwrapped

    # faster nix search
    nix-search-cli

    starship

    # ghostty
    wezterm
    helix
    vscode

    # doom emacs base deps
    git
    emacs
    ripgrep
    fd
    coreutils
    clang
    pandoc
    shellcheck
    shfmt
    cmake
    gnumake
    gcc
    libtool
    # libvterm
    libvterm-neovim

    # global bash bin for lsp
    bash-language-server

    wl-clipboard
    # an alternative to tree xD
    # tre
    eza

    trashy

    eza
    bat
    fastfetch

    # c-dev stuff
    clang-tools

    # language server binaries
    nil
    zls
    # lua-language-server

    # application binaries
    exercism

    # note taking app
    obsidian
    # notion-app # no x86_64-linux release :(
    # notion-app-enhanced

    # element-desktop, front-end for matrix.org
    element-desktop

    # system lib
    libGL

    # direnv

    # nix-index
    nix-index

    # MS teams for linux
    # teams-for-linux
    # Zoom-us
    zoom-us
    # Cisco Webex
    webex

    # obs-studio
    # obs-studio

    # Terminal Tools
    zellij

    # Preview markdown using cli
    glow

    # Modern Terminal
    # termius

    # PenTesting Tools
    # burpsuite
    # wireshark

    # fast search
    # ripgrep
  ];

  # environment.variables = {
  #   EDITOR = "emacsclient -nw -a ''";
  #   VISUAL = "emacsclient -nw -a ''";
  # };

  fonts.packages = with pkgs; [
    iosevka
    iosevka-comfy.comfy
    nerd-fonts.symbols-only
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" "Hack" ]; })
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  hardware = {
    graphics.enable = true;
    # opengl.driSupport = true;
    # graphics.enable32Bit= true;

    graphics.extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      # vaapiVdpau
      libvdpau-va-gl
    ];
    # bluetooth.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     stdenv.cc.cc.lib
  #   ];
  # };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      # update = "sudo nixos-rebuild switch";
      upns = "sudo nixos-rebuild switch --flake .#";
    };

    # shellInit = ''
    # '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

  # programs.bash = {
  #   enable = true;
  #   # initExtra = ''
  #   shellInit = ''
  #   #   cd ~

  #   #   echo "hello shell init"
  #     # export PROMPT_DIRTRIM=1

  #     if [[ $- == *i* ]]; then
  #       stty susp undef
  #       bind '"\C-z":" fg\015"'
  #     fi

  #     # direnv hook
  #     eval "$(direnv hook bash)"

  #   #   # Make sure to set the UV_PYTHON_DOWNLOADS=never
  #   #   # environment variable in your shell to stop uv from downloading Python binaries.
  #   #   export UV_PYTHON_DOWNLOADS=never

  #   #   ll = "ls -al";
  #   '';

  #   # shellInit = ''
  #   # '';

  #   shellAliases = {};
  # };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3; # Use pkgs.pinentry-qt for KDE/Qt desktops
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "goatdjar";
      user.email = "119997863+goatdjar@users.noreply.github.com";
      core.editor = "emacs";
      init.defaultBranch = "main";
      credential.helper = "libsecret";
      # credential.credentialStore = "cache";
      # user.signingkey = "506E6F22CFB227E3BAA704505168E490A393E212";
      user.signingkey = "5270C87E308FF2F7FC14E7F13556305CEAA29F4A";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
