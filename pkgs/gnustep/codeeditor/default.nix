{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "code_editor";
  version = "0.4.4";

  src = fetchurl {
    url = "http://download.savannah.nongnu.org/releases/codeeditor/CodeEditor-${version}.tar.gz";
    sha256 = "0vqbg06k8zvrkmy1pbk2q2isdkqndng79dnskznh07f4ai8x3r1j";
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    # likely suffers from bitrot
    broken = true;
    description =
      "CodeEditor is a non-rich text editor for GNUstep with several enhancement for code editing";
    homepage = "https://www.nongnu.org/codeeditor/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
