# vim: sw=2 ts=2 et
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dactyl-remote-control = {
      url = "github:kasama/dactyl-remote-control";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tailscale-multitail = {
      url = "github:kasama-jay/tailscale-multitail/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, dactyl-remote-control, ... }@inputs: {
      nixosConfigurations.kasama-acer = let
        helpers = {
          get_modules = let
            inherit (nixpkgs) lib;
            inherit (builtins) readDir hasAttr;
            inherit (lib) pipe filterAttrs mapAttrsToList hasPrefix hasSuffix;

            ignore_prefix = "_";

            is_dir_module = dir: pipe dir [ readDir (hasAttr "default.nix") ];

            get_modules = dir:
              pipe dir [
                readDir
                (filterAttrs (name: type:
                  if type == "directory" then
                    is_dir_module (lib.path.append dir name)
                  else
                    hasSuffix ".nix" name))
                (filterAttrs (name: _: !(hasPrefix ignore_prefix name)))
                (mapAttrsToList (name: _: (lib.path.append dir name)))
              ];
          in get_modules;
        };
      in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit home-manager;
          inherit dactyl-remote-control;
          inherit helpers;
        };
        modules = [
          ./hosts/kasama-acer/configuration.nix
          inputs.kmonad.nixosModules.default
        ];
      };
    };
}
