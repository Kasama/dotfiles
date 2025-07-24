{ config, lib, pkgs, ... }:
{
  options = {
    spacetimedb.enable = lib.mkEnableOption "enable spacetimedb";
  };

  config = lib.mkIf config.spacetimedb.enable {
    # https://github.com/clockworklabs/SpacetimeDB/releases/download/v1.2.0/spacetime-x86_64-unknown-linux-gnu.tar.gz
  };
}
