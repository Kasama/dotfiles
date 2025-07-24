{ lib, pkgs, config, ... }: {
  options = { desktop.steam.enable = lib.mkEnableOption "enables steam"; };

  config = lib.mkIf config.desktop.enable
    (lib.mkIf config.desktop.steam.enable {
      programs.steam = { enable = true; };

      environment.systemPackages = with pkgs; [ steam ];
    });
}
