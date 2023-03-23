{ lib
, fetchFromGitHub
, gnustep
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

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
  ];

  meta = with lib; {
    # marked as broken bc `gnustep.libs-xcode` does not
    # exist in nixpkgs
    broken = true;
    description = "dual-pane file manager for macOS";
    homepage = "https://magnumbytes.com/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}