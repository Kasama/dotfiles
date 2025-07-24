{ config, pkgs, lib, ... }: {
  options = { nh.enable = lib.mkEnableOption "enable nh"; };
  config = {
    environment.sessionVariables = {
      NH_FLAKE = "/home/${config.username}/dotfiles/nixos";
    };

    environment.systemPackages = with pkgs; [ nh nix-tree ];
  };

}
