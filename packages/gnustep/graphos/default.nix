{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "graphos";
  version = "0.7";

  src = fetchurl {
    url = "http://savannah.nongnu.org/download/gap/Graphos-${version}.tar.gz";
    sha256 = "02w16h66a9kfm0d40m5xvwq11srcl0fcjg3kf9jsb1s74iymd8nj";
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    description = "File synchronization tool for GNUstep";
    homepage = "https://gap.nongnu.org/graphos/";
    # license is noted in the info panel
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
