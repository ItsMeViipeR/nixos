{
  description = "NixOS 26.05 stable";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
	  ./configuration.nix
        ];
      };
    };
  };
}
