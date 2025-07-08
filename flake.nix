{
  description = "nix darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }: {
    darwinConfigurations.default = nix-darwin.lib.darwinSystem {
      modules = [ ./darwin/default.nix ./home-manager.nix ];
      specialArgs = {
        inherit inputs self;
        user = {
          name = "alban";
          home = "/Users/alban";
        };
      };
    };

    darwinPackages = self.darwinConfigurations.default.pkgs;
  };
}
