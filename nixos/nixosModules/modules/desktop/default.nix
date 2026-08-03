{ config, lib, pkgs, helpers, ... }: {
  imports = helpers.get_modules ./modules;

  options = {
    desktop.enable = lib.mkEnableOption "enable desktop";
    desktop.kind = lib.mkOption {
      default = "x11";
      example = "wayland, x11";
      description =
        "defines if the current environment is running x11 or wayland";
    };
  };

  config = lib.mkIf config.desktop.enable {
    desktop.i3.enable = lib.mkDefault true;
    desktop.hyprland.enable = lib.mkDefault false;
    desktop.games.enable = lib.mkDefault config.desktop.enable;
    desktop.steam.enable = lib.mkDefault config.desktop.enable;
    # desktop.dactyl-remote-control.enable = lib.mkDefault config.desktop.enable;

    environment.systemPackages = let
      xOrWaylandPkgs = if config.desktop.kind == "wayland" then
        with pkgs; [ wl-clipboard waynergy ]
      else
        with pkgs; [ xorg.xinit xorg.xset xsel ];
    in with pkgs;
    [
      alsa-utils
      blueman
      bluez
      discord
      evtest
      f3
      feh
      feishin
      firefox
      ghostty
      gnome-network-displays
      kdePackages.breeze
      kdePackages.breeze-gtk
      keepassxc
      libinput
      networkmanagerapplet
      owncloud-client
      pulseaudio
      spotify
      sunshine
      telegram-desktop
      vimix-icon-theme
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      vlc
      zathura
    ] ++ xOrWaylandPkgs;

    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
    };

    networking.firewall = {
      trustedInterfaces = [ "p2p-wl+" ];

      allowedTCPPorts = [ 47984 47989 47990 48010 7236 7250 ];
      allowedUDPPorts = [ 7236 5353 ];
      allowedUDPPortRanges = [
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      siji
      (pkgs.stdenv.mkDerivation {
        name = "fontawesome";
        src = ./modules/fonts;
        installPhase = ''
          install -Dm644 fontawesome.ttf $out/share/fonts/fontawesome.ttf
        '';
      })
      nerd-fonts.iosevka
      nerd-fonts.fira-code
    ];

    hardware.bluetooth.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override { extraPkgs = pkgs: [ pkgs.icu ]; };
    };
  };
}
