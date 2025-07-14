{
  pkgs,
  ...
}:

{
  enable = true;

  profiles.default.extensions = with pkgs; [
    vscode-extensions.jnoortheen.nix-ide
    vscode-extensions.pkief.material-icon-theme
    vscode-extensions.esbenp.prettier-vscode
    vscode-extensions.dbaeumer.vscode-eslint
    vscode-extensions.christian-kohler.path-intellisense
    vscode-extensions.christian-kohler.npm-intellisense
    #vscode-extensions.dsznajder.es7-react-js-snippets
  ];

  profiles.default.userSettings = {
    # General
    "editor.formatOnSave" = true;
    "terminal.integrated.fontFamily" = "'MesloLGS Nerd Font'";

    # Icon
    "workbench.iconTheme" = "material-icon-theme";
    "material-icon-theme.activeIconPack" = "react";

    # Nix
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
  };
}
