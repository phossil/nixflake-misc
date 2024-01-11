{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "UnifrakturMaguntia";
  version = "2017-03-19";

  src = fetchzip {
    url = "mirror://sourceforge/unifraktur/fonts/${pname}.${version}.zip";
    hash = "sha256-GhutYxslqu0WN/4Pk44eMY86z+bfdUvGep5YHtTLWIw=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://unifraktur.sourceforge.net/maguntia.html";
    description = "a Unicode Fraktur Font";
    maintainers = with maintainers; [ phossil ];
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
