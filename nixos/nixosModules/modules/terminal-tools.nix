{ config, lib, pkgs, ... }: {
  options = {
    terminal-tools.enable = lib.mkEnableOption "enable terminal-tools";
  };

  config = lib.mkIf config.terminal-tools.enable {
    environment.systemPackages = with pkgs; [
      ansible
      arp-scan
      bat
      bubblewrap
      diff-so-fancy
      dig
      dust
      file
      fzf
      git
      gnupg
      gnumake
      imagemagick
      htop
      killall
      neovim
      unzip
      vim
      wget
      openssl
      inotify-tools
      jq
      yazi
      yq
      yt-dlp
      pay-respects
      pkg-config
      ffmpeg
      nfs-utils
    ];

    programs.nix-ld.enable = true;
  };
}
