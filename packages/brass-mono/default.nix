{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "brass_mono";
  version = "1.101";

  src = fetchzip {
    url = "https://github.com/fonsecapeter/${pname}/releases/download/v${version}/BrassMono.zip";
    hash = "sha256-XamUFHuVRnCUadLdERG9AipiRGWe88+CdxY6+FFyerE=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/fonsecapeter/brass_mono";
    description = "Monospaced font inspired by retro industrial design";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
