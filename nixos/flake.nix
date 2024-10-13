{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, nur, sops-nix, ... }: let
    system = "x86_64-linux";
    hostname = "fgk";
    adminUser = "flekgekei";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system; 
      specialArgs = {
	meta = {
	  inherit hostname adminUser;
	};
      };
      modules = [ 
	{ nixpkgs.overlays = [ nur.overlay ]; }
	#({ pkgs, ... }:
	#  let
	#    nur-no-pkgs = import nur {
	#      nurpkgs = import nixpkgs { system = ${system}; };
	#    };
	#  in {
	#    imports = [ 
	#      nur-no-pkgs.repos.ataraxiasjel.modules.
	#    ];
	#})
        ./configuration.nix 
        nixvim.nixosModules.nixvim
	sops-nix.nixosModules.sops
      ];
    };

    homeConfigurations.${adminUser} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ 
        /home/${adminUser}/.config/home-manager/home.nix 
      ];
    };
  };
}
