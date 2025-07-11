{
  description = "nix darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";

      overlay = final: prev: {
        musicpresence = prev.callPackage ./home/custom-pkgs/musicpresence.nix { };
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/default.nix
          ./home-manager.nix
          {
            nixpkgs.overlays = [ overlay ];
            nixpkgs.hostPlatform = system;
          }
        ];
        specialArgs = {
          inherit inputs self pkgs;
          user = {
            name = "alban";
            home = "/Users/alban";
          };
        };
      };

      darwinPackages = pkgs;
    };
}
