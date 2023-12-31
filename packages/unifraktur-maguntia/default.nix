{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "UnifrakturMaguntia";
  version = "2017-03-19";

  src = fetchzip {
    url = "mirror://sourceforge/unifraktur/fonts/${pname}.${version}.zip";
    hash = "sha256-GuH6DnZcRF4DeX0zlo8vlltcdWU0E3HzJ8Ac/OhIHlY=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ "${pname}.${version}"/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://unifraktur.sourceforge.net/maguntia.html";
    description = "a Unicode Fraktur Font";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
