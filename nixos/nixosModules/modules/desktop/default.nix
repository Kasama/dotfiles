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

    environment.systemPackages = let
      xOrWaylandPkgs = if config.desktop.kind == "wayland" then
        with pkgs; [ wl-clipboard waynergy ]
      else
        with pkgs; [ xorg.xinit xorg.xset xsel ];
    in with pkgs;
    [
      feh
      ghostty
      keepassxc
      owncloud-client
      telegram-desktop
      discord
      feishin
      spotify
      networkmanagerapplet
      sunshine
      pulseaudio
      alsa-utils
      evtest
      libinput
      blueman
      bluez
      kdePackages.breeze
      kdePackages.breeze-gtk
      vimix-icon-theme
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      zathura
    ] ++ xOrWaylandPkgs;

    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
    };

    networking.firewall = {
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
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
  };
}
