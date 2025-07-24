{ pkgs, ... }:

let plymouth_theme = "polaroid";
in {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;
    theme = plymouth_theme;
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };

  environment.systemPackages = with pkgs; [
    (adi1090x-plymouth-themes.override {
      selected_themes = [ plymouth_theme ];
    })
    plymouth
  ];
}
