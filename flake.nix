{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, nixvim, ... }: 
    let 
      system = "x86_64-linux";
    in {
    nixosConfigurations.fgk = nixpkgs.lib.nixosSystem {
      inherit system; 
      modules = [ 
        ./configuration.nix 
        nixvim.nixosModules.nixvim
      ];
    };

    homeConfigurations.flekgekei = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ 
        /home/flekgekei/.nix/home.nix 
      ];
    };
  };
}
