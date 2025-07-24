{ pkgs, lib, config, ... }: {

  options = { desktop.i3.enable = lib.mkEnableOption "enables i3"; };

  config = lib.mkIf (lib.and config.desktop.enable config.desktop.i3.enable) {
    environment.systemPackages = with pkgs; [
      (polybar.override { i3Support = true; })
      feh
      i3
      keepassxc
      owncloud-client
      libsecret
      picom
      playerctl
      pulseaudio
      rofi
      rofi-calc
    ];

    security.pam.services = {
      i3lock.enable = true;
      i3lock-color.enable = true;
      xlock.enable = true;
      xscreensaver.enable = true;
    };

    services.displayManager.defaultSession = "xfce+i3";

    services.xserver = {
      enable = true;

      # displayManager.enable = false;
      # desktopManager.enable = false;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };

      displayManager = {
        sessionCommands = "${pkgs.xorg.xset}/bin/xset r rate 200 50";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };

      # xkbOptions = "ctrl:swapcaps";

      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
    };

    services.picom.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "br";
      variant = "thinkpad";
    };

  };

}
