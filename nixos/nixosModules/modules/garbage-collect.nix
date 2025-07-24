{ lib, config, ... }: {
  options = {
    garbage-collect.enable = lib.mkEnableOption "enables garbage collection";
    garbage-collect.delete-older-than = lib.mkOption { default = "2d"; };
  };

  config = {
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "weekly";

    nix.gc.automatic = true;
    nix.gc.dates = "daily";
    nix.gc.options =
      "--delete-older-than ${config.garbage-collect.delete-older-than}";
    nix.settings.auto-optimise-store = true;
  };
}
