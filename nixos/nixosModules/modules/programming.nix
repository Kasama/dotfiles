{ config, lib, pkgs, ... }: {
  options = { programming.enable = lib.mkEnableOption "enable programming"; };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      # languages
      gcc
      gnumake
      go
      nodejs
      python3
      rustup

      # programming tools
      fzf
      mise
      neovim
      ripgrep
      tmux
    ];
  };
}
