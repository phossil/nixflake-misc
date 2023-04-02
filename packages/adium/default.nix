{ lib
, fetchFromGitHub
, gnustep
, gnustep-xcode
}:

gnustep.gsmakeDerivation rec {
  pname = "adium";
  version = "1.5.8";

  src = fetchFromGitHub {
    owner = "adium";
    repo = pname;
    rev = version;
    sha256 = "Y+g3R1xLN4AggM5GKNPcvqdFPRbGFpVmgSaoj2OXkCw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    gnustep-xcode
  ];

  buildInputs = with gnustep; [ base back gui ];

  postPatch = ''
    # Fix install path
    substituteInPlace Makefile \
      --replace "~/Applications" "$out/bin"
  '';

  buildPhase = ''
    runHook preBuild

    ${gnustep-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # broken, gnustep.xcode is WIP
    broken = true;
    description =
      "A free and open source instant messaging application for OS X";
    homepage = "https://adium.im/";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
