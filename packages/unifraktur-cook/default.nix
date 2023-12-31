{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "UnifrakturCook";
  version = "2013-08-25";

  src = fetchzip {
    url = "mirror://sourceforge/unifraktur/fonts/${pname}.${version}.zip";
    hash = "sha256-nS7TN4fzw9+bCaAfeHsZ9uDDLkcjnrr7tk6NGk6ajMQ=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ "${pname}.${version}"/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://unifraktur.sourceforge.net/cook.html";
    description = "a Unicode Fraktur Font";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
