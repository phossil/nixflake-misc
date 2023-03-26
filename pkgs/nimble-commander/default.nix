{ lib
, fetchFromGitHub
, gnustep
, gnustep-xcode
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
    gnustep-xcode
  ];

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
  ];

  buildPhase = ''
    runHook preBuild

    ${gnustep-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # broken, gnustep.xcode is WIP
    broken = true;
    description = "dual-pane file manager for macOS";
    homepage = "https://magnumbytes.com/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
