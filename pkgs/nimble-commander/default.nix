{ lib
, fetchFromGitHub
, gnustep
, libs-xcode
}:

gnustep.gsmakeDerivation rec {
  pname = "nimble-commander";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "mikekazakov";
    repo = pname;
    rev = "073439e280b3d8d57115588c87c7e39fd29c9387";
    sha256 = "huEFLwAxWyQOjv1+qOLnJurV2akAcyRQaWiKmuJztkM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    libs-xcode
  ];

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
  ];

  buildPhase = ''
    runHook preBuild

    ${libs-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # marked as broken bc no executable is installed
    broken = true;
    description = "dual-pane file manager for macOS";
    homepage = "https://magnumbytes.com/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
