{ config, lib, pkgs, ... }: {
  options = { programming.enable = lib.mkEnableOption "enable programming"; };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      # languages
      # .NET 8 SDK
      dotnetCorePackages.sdk_8_0_4xx-bin
      gcc
      gnumake
      go
      nodejs
      python3
      uv
      rustup

      # programming tools
      fzf
      mise
      neovim
      ripgrep
      tmux
      git-lfs
      android-tools
    ];
  };
}
