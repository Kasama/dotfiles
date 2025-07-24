# vim: sw=2 ts=2 et
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, config, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./../../nixosModules
    ./hardware-configuration.nix
  ];

  desktop = {
    enable = true;
    i3.enable = false;
    hyprland.enable = true;
  };

  username = "roberto";

  garbage-collect.enable = true;

  terminal-tools.enable = true;

  programming.enable = true;

  networking.hostName = "kasama-acer"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.nixPath = [ "/home/${config.username}/dotfiles/nixos" ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  fonts.packages = with pkgs; [ noto-fonts noto-fonts-cjk-sans siji ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.username} = {
    isNormalUser = true;
    description = "${config.username}";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" "docker" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable automatic login for the user.
  services.getty = {
    autologinUser = "${config.username}";
    autologinOnce = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ avahi docker ghostty ];

  services.avahi = {
    enable = true;
    publish.enable = true;
    publish.userServices = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 22 47984 47989 47999 47990 48010 ];
    allowedUDPPorts = [ 22 47984 47989 47999 47990 48010 ];
  };

  # Configure console keymap
  console = {
    # keyMap = "br-abnt2";
    useXkbConfig = true;
  };

  environment.variables = {
    ROFI_PLUGIN_PATH = "/run/current-system/sw/lib/rofi";
    TERMINAL = "ghostty";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
  # programs.rofi = {
  #   enable = true;
  #   plugins = [ pkgs.rofi-calc ];
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  systemd.tmpfiles.rules = [ "L+ /bin/bash - - - - ${pkgs.bash}/bin/bash" ];
}
