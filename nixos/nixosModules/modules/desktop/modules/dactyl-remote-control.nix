{ config, lib, pkgs, inputs, ... }: {

  # imports = [ inputs.dactyl-remote-control.nixosModules.dactyl-remote-control ];

  # options = {
  #   desktop.dactyl-remote-control.enable =
  #     lib.mkEnableOption "enable dactyl-remote-control";
  # };

  # config = lib.mkIf config.desktop.dactyl-remote-control.enable {
  #   services.dactyl-remote-control = {
  #     enable = true;
  #     vid = "0x4B41";
  #     pid = "0x636D";
  #     configPath = "/home/roberto/.config/dactyl/config.yaml";
  #     user = "roberto";
  #   };
  # };
}
