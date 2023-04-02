{ lib
, fetchFromGitHub
, gnustep
, gnustep-xcode
}:

gnustep.gsmakeDerivation rec {
  pname = "hex_fiend";
  version = "2.16.0";

  src = fetchFromGitHub {
    owner = "HexFiend";
    repo = "HexFiend";
    rev = "v${version}";
    sha256 = "TB8wkV7jxCOlEsAQV25zMn0RJCJ+tNvg5G+5JipZMaA=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    gnustep-xcode
  ];

  buildInputs = with gnustep; [ base back gui ];

  buildPhase = ''
    runHook preBuild

    ${gnustep-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # broken, gnustep.xcode is WIP
    broken = true;
    description = "A fast and clever open source hex editor for macOS";
    homepage = "http://ridiculousfish.com/hexfiend/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
