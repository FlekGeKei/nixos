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
  };

  outputs = { nixpkgs, home-manager, nixvim, nur, ... }: 
    let 
      system = "x86_64-linux";
    in {
    nixosConfigurations.fgk = nixpkgs.lib.nixosSystem {
      inherit system; 
      modules = [ 
	{ nixpkgs.overlays = [ nur.overlay ]; }
	({ pkgs, ... }:
	  let
	    nur-no-pkgs = import nur {
	      nurpkgs = import nixpkgs { system = "x86_64-linux"; };
	    };
	  in {
	    #imports = [ 
	    #  nur-no-pkgs.repos.ataraxiasjel.modules.
	    #];
	})
        ./configuration.nix 
        nixvim.nixosModules.nixvim
      ];
    };

    homeConfigurations.flekgekei = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ 
        /home/flekgekei/.config/home-manager/home.nix 
      ];
    };
  };
}
