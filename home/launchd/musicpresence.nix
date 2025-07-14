{ pkgs, ... }:

{
  enable = true;
  config = {
    Label = "dev.alban.MusicPresence";
    RunAtLoad = true;
    KeepAlive = false;
    ProgramArguments = [
      "/usr/bin/open"
      "-a"
      "${pkgs.musicpresence}/Applications/Music Presence.app"
    ];
    StandardOutPath = "/dev/null";
    StandardErrorPath = "/dev/null";
  };
}
