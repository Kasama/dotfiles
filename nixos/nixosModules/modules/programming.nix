{ config, lib, pkgs, ... }: {
  options = { programming.enable = lib.mkEnableOption "enable programming"; };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      # languages
      # dotnet-sdk_10
      dotnetCorePackages.sdk_8_0_3xx-bin
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
