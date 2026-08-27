# { config, pkgs, ... }: {
#   environment.systemPackages = with pkgs; [ tailscale ];
#
#   services.tailscale = { enable = true; };
# }
#

{
  config,
  pkgs,
  ...
}:
let
  version = "1.0.0-beta.7";

  tsmultitail = pkgs.stdenvNoCC.mkDerivation {
    pname = "tailscale-multitail";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/kasama-jay/tailscale-multitail/releases/download/v${version}/tailscale-multitail_${version}_linux_amd64.tar.gz";
      hash = "sha256-Z4R1Jj/aqCHOVMgVhkFa9nmAvkDyRTYPGe4FKxIgwys=";
    };

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      tar -xzf "$src"
    '';

    sourceRoot = "tailscale-multitail_${version}_linux_amd64";

    installPhase = ''
      install -Dm755 tailscale-multitaild "$out/bin/tailscale-multitaild"
      install -Dm755 tsmultitail "$out/bin/tsmultitail"
    '';
  };

  yaml = pkgs.formats.yaml { };

  multitailConfig = yaml.generate "tailscale-multitail-config.yaml" {
    version = 1;
    interface = "multitail0";
    routing_table = 552;
    mtu = 1280;
    effective_ipv4_cidr = "10.192.0.0/16";

    profiles = [
      {
        id = "f9d90873-402b-438a-b194-0db4047d9601";
        name = "work";
        hostname = "kasama-acer-nixos";
      }
      {
        id = "736cf9c2-3b83-4317-aaa3-ac58f293d4ea";
        name = "homelab";
        hostname = "kasama-acer-nixos";
      }
    ];
  };
in
{
  assertions = [
    {
      assertion = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
      message = "The beta.7 release asset supports x86_64-linux only.";
    }
  ];

  # Do not run native tailscaled with multitail.
  services.tailscale.enable = false;

  environment.systemPackages = [ tsmultitail ];

  users.groups.tsmultitail = { };
  users.users.${config.username}.extraGroups = [ "tsmultitail" ];

  environment.etc."tailscale-multitail/config.yaml" = {
    source = multitailConfig;
    mode = "0640";
    user = "root";
    group = "tsmultitail";
  };

  systemd.services.tailscale-multitail = {
    description = "Multi-tailnet host networking daemon";

    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "systemd-resolved.service"
    ];
    conflicts = [ "tailscaled.service" ];

    serviceConfig = {
      ExecStart = "${tsmultitail}/bin/tailscale-multitaild run --host-tun --resolved --socket=/run/tailscale-multitail/control.sock";

      Restart = "on-failure";
      RestartSec = "5s";
      RestartForceExitStatus = "75";
      RestartPreventExitStatus = "1 2";

      User = "root";
      Group = "tsmultitail";
      UMask = "0077";

      RuntimeDirectory = "tailscale-multitail";
      RuntimeDirectoryMode = "0750";
      StateDirectory = "tailscale-multitail";

      CapabilityBoundingSet = [
        "CAP_NET_ADMIN"
        "CAP_NET_BIND_SERVICE"
      ];
      AmbientCapabilities = [
        "CAP_NET_ADMIN"
        "CAP_NET_BIND_SERVICE"
      ];

      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectHome = true;
      ProtectSystem = "strict";
      ReadWritePaths = [
        "/var/lib/tailscale-multitail"
        "/run/tailscale-multitail"
      ];
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      LockPersonality = true;
      RestrictSUIDSGID = true;
    };
  };
}
