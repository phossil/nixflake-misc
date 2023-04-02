{ lib
, fetchFromGitHub
, gnustep
, gnustep-xcode
}:

gnustep.gsmakeDerivation rec {
  pname = "filer";
  version = "2022-12-28";

  src = fetchFromGitHub {
    owner = "ravynsoft";
    repo = pname;
    rev = "461eb2e8399aeefd8c456ca26d2d2e5435564b21";
    sha256 = "Ajf9Y7UhsbFTnKK4MWo1gY5eQjypSEZo5L/tgyXTT7M=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    gnustep-xcode
  ];

  buildInputs = with gnustep; [ base back gui ];

  postPatch = ''
    # Makefile expects find a version file in
    # a parent directory
    substituteInPlace Makefile \
      --replace "head -1 ../../version.txt" "echo alpha"
  '';

  buildPhase = ''
    runHook preBuild

    ${gnustep-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # fails due to missing headers(?)
    broken = true;
    description = "RavynOS File manager built in Cocoa/Appkit and ObjC ";
    homepage = "https://ravynos.com/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
