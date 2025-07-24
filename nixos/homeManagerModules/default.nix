# vim: sw=2 ts=2 et

{ config, pkgs, inputs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [ ];

  home.packages = with pkgs; [
    (inputs.zen-browser.packages."${system}".default)
    awscli2
    discord
    eza
    keepassxc
    playerctl
    telegram-desktop
    tmux
    owncloud-client
    ripgrep
    kubectl
    mise
  ];

  programs.ssh = { enable = true; };

  services.ssh-agent = { enable = true; };

  xdg.enable = true;

  # wayland = {
  #   windowManager.hyprland = {
  #     enable = true;
  #     plugins = with pkgs; [ ];
  #   };
  # };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    TERMINAL = "ghostty";
    SUDO_ASKPASS = "${builtins.getEnv "SSH_ASKPASS"}";
  };

  home.stateVersion = "25.05";
}
