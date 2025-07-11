{ config, pkgs, lib, user, ... }:

{
  enable = true;
  history.size = 10000;

  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    plugins = [ "sudo" "git" "z" "colored-man-pages" ];
    custom = "${user.home}/.oh-my-zsh/custom";
  };

  initContent = ''
    # Activer powerlevel10k
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

    # Charger config si elle existe
    [[ -f "${user.home}/.p10k.zsh" ]] && source "${user.home}/.p10k.zsh"

  '';
}
