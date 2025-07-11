{
  stdenvNoCC,
  fetchurl,
  undmg,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "musicpresence";
  version = "2.3.1";

  src = fetchurl {
    url = "https://github.com/ungive/discord-music-presence/releases/download/v${finalAttrs.version}/${finalAttrs.pname}-${finalAttrs.version}-mac-arm64.dmg";
    sha256 = "jU7jCxsy9IomQrba2eaOJJ6ObqgFCddy+FHLATv6JtU=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ undmg ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    mv "Music Presence.app" "$out/Applications"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

})
