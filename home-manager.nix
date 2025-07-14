{
  inputs,
  config,
  user,
  pkgs,
  lib,
  ...
}:

let
  username = user.name;
  homeDir = user.home;
in
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;

  home-manager.users.${username} = {
    home.stateVersion = "25.05";
    imports = [ ./macos-apps-fix.nix ];

    home.file.".p10k.zsh".source = ./home/theme/.p10k.zsh;

    home.packages = with pkgs; [
      zsh-powerlevel10k
      zsh-autosuggestions
      zsh-syntax-highlighting
      arc-browser
      iterm2
      vscode
      rectangle
      discord
      colima
      docker
      musicpresence
    ];

    programs = {
      zsh = import ./home/programs/zsh.nix { inherit pkgs user; };
      vscode = import ./home/programs/vscode.nix { inherit pkgs; };
    };

    launchd.agents = {
      rectangle = import ./home/launchd/rectangle.nix { inherit pkgs; };
      musicpresence = import ./home/launchd/musicpresence.nix { inherit pkgs; };
      # docker = import ./home/launchd/docker.nix { inherit config pkgs; };
    };
  };
}
