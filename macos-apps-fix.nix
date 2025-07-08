{ pkgs, config, lib, ... }:

{
  home.activation = {
    copyNixApps = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      # Variables
      TARGET_DIR="$HOME/Applications/Nix-Apps"
      NIXAPPS=$(realpath "$HOME/Applications/Home Manager Apps" 2>/dev/null || echo "")

      # Vérifier que le dossier existe
      if [ -z "$NIXAPPS" ] || [ ! -d "$NIXAPPS" ]; then
        echo "Aucune application Nix trouvée dans $HOME/Applications/Home Manager Apps"
        exit 0
      fi

      # Créer le dossier cible
      mkdir -p "$TARGET_DIR"
      rm -rf "$TARGET_DIR"/*

      echo "Copie des applications Nix vers $TARGET_DIR..."

      for app_source in "$NIXAPPS"/*; do
        if [ -d "$app_source" ] || [ -L "$app_source" ]; then
          appname=$(basename "$app_source")
          target="$TARGET_DIR/$appname"

          mkdir -p "$target/Contents"

          # Copie du Info.plist
          if [ -f "$app_source/Contents/Info.plist" ]; then
            cp -f "$app_source/Contents/Info.plist" "$target/Contents/"
          fi

          # Copie des icônes
          if [ -d "$app_source/Contents/Resources" ]; then
            mkdir -p "$target/Contents/Resources"
            find "$app_source/Contents/Resources" -name "*.icns" -exec cp -f {} "$target/Contents/Resources/" \;
          fi

          # Lien symbolique vers le binaire
          if [ -d "$app_source/Contents/MacOS" ]; then
            ln -sfn "$app_source/Contents/MacOS" "$target/Contents/MacOS"
          fi

          # Lien vers les autres dossiers
          for dir in "$app_source/Contents"/*; do
            dirname=$(basename "$dir")
            if [ "$dirname" != "Info.plist" ] && [ "$dirname" != "Resources" ] && [ "$dirname" != "MacOS" ]; then
              ln -sfn "$dir" "$target/Contents/$dirname"
            fi
          done
        fi
      done
    '';
  };
}
