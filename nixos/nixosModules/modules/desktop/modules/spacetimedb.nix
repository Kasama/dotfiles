{ config, lib, pkgs, ... }:
{
  options = {
    spacetimedb.enable = lib.mkEnableOption "enable spacetimedb";
  };

  config = lib.mkIf config.spacetimedb.enable {
    environment.systemPackages = with pkgs; [
      spacetimedb
    ];
  };
}
