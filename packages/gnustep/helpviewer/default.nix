{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "help_viewer";
  version = "0.4";

  src = fetchurl {
    url = "http://savannah.nongnu.org/download/gap/HelpViewer-${version}.tar.gz";
    sha256 = "15f9jfm30d6dx98hsr0shd07j0i45dyic4acx3abighzb1pzs65j";
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    description = "Help Viewer for GNUstep";
    homepage = "https://www.nongnu.org/gap/helpviewer/index.html";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
