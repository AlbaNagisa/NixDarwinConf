{ config, pkgs, ... }:

{
  enable = true;
  config = {
    Label = "dev.alban.Docker";
    RunAtLoad = true;
    KeepAlive = false;
    ProgramArguments =
      [ "/usr/bin/open" "-a" "${pkgs.docker}/Applications/Docker.app" ];
    StandardOutPath = "/dev/null";
    StandardErrorPath = "/dev/null";
  };
}
