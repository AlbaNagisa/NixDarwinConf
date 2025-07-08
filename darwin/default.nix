{ config, pkgs, user, ... }: {

  environment.systemPackages = with pkgs; [ nixfmt-classic ];

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg nerd-fonts.jetbrains-mono ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  users.users.alban = {
    name = user.name;
    home = user.home;
  };

  system.configurationRevision = config.system.rev or null;
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
