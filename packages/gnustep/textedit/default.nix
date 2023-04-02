{ lib
, fetchFromGitHub
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "text_edit";
  version = "2016-05-05";

  src = fetchFromGitHub {
    owner = "ericwa";
    repo = "TextEdit";
    rev = "41ba8ca9c070a6fb13de059453fec19409e65839";
    sha256 = "qUUGlOiFExYzQxNoOLiJAfM6mTEUYE2mdaAoJvGIGf4=";
    fetchSubmodules = true;
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    description = " GNUstep port of OS X 10.6 TextEdit";
    homepage = "https://github.com/ericwa/TextEdit";
    # copyright information not provided
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
