{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.desktop.hyprland.enable {
    desktop.kind = "wayland";

    programs.hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      # instruct Electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      bibata-cursors
      brightnessctl
      dunst
      graphite-cursors
      hypridle
      hyprland-qt-support
      hyprland-qtutils
      hyprlandPlugins.hy3
      hyprlock
      hyprpaper
      hyprpolkitagent
      hyprshot
      libnotify
      nwg-look
      pavucontrol
      pulseaudio
      quickshell
      rofi
      rofi-calc
      rose-pine-cursor
      volumeicon
      waybar
      xdg-desktop-portal-hyprland
    ];

    environment.etc = {
      "hypr/hy3-plugin.conf" = {
        text = ''
          plugin = ${pkgs.hyprlandPlugins.hy3.outPath}/lib/libhy3.so
        '';
      };
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "agreety --cmd /bin/bash";
          user = "greeter";
        };

        initial_session = {
          command = "zsh --login -c start-hyprland";
          user = "${config.username}";
        };
        terminal.vt = 1;
      };
    };
  };
}
