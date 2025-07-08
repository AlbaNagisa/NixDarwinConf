{ config, pkgs, lib, ... }:

let homeDir = config.home.homeDirectory;
in {
  programs.zsh = {
    enable = true;

    history.size = 10000;

    initContent = ''
      # Activer powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Charger config si elle existe
      [[ -f "${homeDir}/.p10k.zsh" ]] && source "${homeDir}/.p10k.zsh"

      # Autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      # Syntax highlighting (doit être chargé en dernier)
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
  };
}
