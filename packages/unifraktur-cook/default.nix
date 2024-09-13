{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "UnifrakturCook";
  version = "2013-08-25";

  src = fetchzip {
    url = "mirror://sourceforge/unifraktur/fonts/${pname}.${version}.zip";
    hash = "sha256-Zz++XLshPntpqhFhy3rwErlAutNWkorBcrjUbNpvHxs=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://unifraktur.sourceforge.net/cook.html";
    description = "a Unicode Fraktur Font";
    maintainers = with maintainers; [ phossil ];
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
