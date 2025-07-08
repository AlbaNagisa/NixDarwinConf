{ inputs, config, user, pkgs, lib, ... }:

let
  username = user.name;
  homeDir = user.home;
in {
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;

  home-manager.users.${username} = {
    imports = [ ./macos-apps-fix.nix ./home/programs/zsh.nix ];

    home.stateVersion = "25.05";
    home.packages = with pkgs; [
      zsh-powerlevel10k
      zsh-autosuggestions
      zsh-syntax-highlighting
      arc-browser
      iterm2
      vscode
      rectangle
      discord
    ];

    home.file.".p10k.zsh".source = ./home/theme/.p10k.zsh;

    launchd.agents = {
      rectangle = import ./home/launchd/rectangle.nix { inherit config pkgs; };
      # docker = import ./home/launchd/docker.nix { inherit config pkgs; };
    };
  };
}
