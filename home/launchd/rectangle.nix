{ config, pkgs, ... }:

{
  enable = true;
  config = {
    Label = "dev.alban.Rectangle";
    RunAtLoad = true;
    KeepAlive = false;
    ProgramArguments =
      [ "/usr/bin/open" "-a" "${pkgs.rectangle}/Applications/Rectangle.app" ];
    StandardOutPath = "/dev/null";
    StandardErrorPath = "/dev/null";
  };
}
