{ inputs, config, ... }: {

  imports = [ inputs.home-manager.nixosModules.default ];
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${config.username}" = import ../../homeManagerModules/default.nix;
      # modules = [ inputs.self.outputs.homeManagerModules.default ];
    };
  };
}
