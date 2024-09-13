{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "brass_mono";
  version = "1.000";

  src = fetchzip {
    url = "https://github.com/fonsecapeter/${pname}/releases/download/v${version}/BrassMono.zip";
    hash = "sha256-+UZasm5Ws4eHiNqYdXr9n61SriPDJlXETN3fNpLrJ0I=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ BrassMono/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/fonsecapeter/brass_mono";
    description = "Monospaced font inspired by retro industrial design";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
