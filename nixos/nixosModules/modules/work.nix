{ config, lib, pkgs, ... }: {
  options = { work.enable = lib.mkEnableOption "enable work"; };

  config = lib.mkIf config.work.enable {
    environment.systemPackages = with pkgs; [ doctl ];
  };
}
