{ lib, config, helpers, ... }: {

  imports = helpers.get_modules ./modules;

  options = {
    username = lib.mkOption {
      description = "username to use for home-manager and other configuration";
    };
  };

  config = {
    desktop.enable = lib.mkDefault true;
    nh.enable = lib.mkDefault true;
  };
}
