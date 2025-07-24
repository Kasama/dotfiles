{ config, lib, pkgs, ... }: {
  options = { desktop.games.enable = lib.mkEnableOption "enable games"; };

  config = lib.mkIf config.desktop.games.enable {
    environment.systemPackages = with pkgs; [ prismlauncher heroic-unwrapped ];
  };
}
