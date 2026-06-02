# ./modules/programs/dev-tools.nix
{ pkgs, ... }:

{
  # Zsh Configuration Matrix
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
    shellAliases = {};
  };

  # Git Identity
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "goatdjar";
      user.email = "119997863+goatdjar@users.noreply.github.com";
      core.editor = "emacs";
      init.defaultBranch = "main";
      credential.helper = "libsecret";
      user.signingkey = "5270C87E308FF2F7FC14E7F13556305CEAA29F4A";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };

  # GnuPG Agent Infrastructure
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Direct Environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Global Development Tooling Profiles
  environment.systemPackages = with pkgs; [
    # Base Builders and Core Utility Binaries
    git emacs ripgrep fd coreutils clang pandoc shellcheck
    shfmt cmake gnumake gcc libtool libvterm-neovim trashy
    stow

    # Compilers / Modern Replacements
    clang-tools eza bat starship zellij glow nix-search-cli

    # Language Servers (LSP)
    bash-language-server nil zls
  ];
}
