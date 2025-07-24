{ config, lib, pkgs, ... }: {
  options = {
    terminal-tools.enable = lib.mkEnableOption "enable terminal-tools";
  };

  config = lib.mkIf config.terminal-tools.enable {
    environment.systemPackages = with pkgs; [
      ansible
      arp-scan
      diff-so-fancy
      dig
      dust
      fzf
      git
      gnumake
      htop
      killall
      neovim
      unzip
      vim
      wget
      inotify-tools
    ];
  };
}
