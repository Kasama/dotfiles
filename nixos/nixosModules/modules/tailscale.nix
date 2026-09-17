{ config, inputs, ... }:

{
  imports = [
    inputs.tailscale-multitail.nixosModules.default
  ];

  # Native tailscaled and multitail cannot coexist.
  services.tailscale.enable = false;

  services.tailscale-multitail = {
    enable = true;

    settings = {
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
  };

  # The imported module creates the group; retain user membership.
  users.users.${config.username}.extraGroups = [ "tsmultitail" ];
}
