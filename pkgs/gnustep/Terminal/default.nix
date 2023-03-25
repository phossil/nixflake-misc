{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "Terminal";
  version = "0.9.9";

  src = fetchurl {
    url = "http://savannah.nongnu.org/download/gap/${pname}-${version}.tar.gz";
    sha256 = "1s90q81wycrp6ngw4n0wal7c5gkk97g2q0c0q3lcs45xrnz1py17";
  };

  buildInputs = with gnustep; [ base gui ];

  meta = with lib; {
    # broken bc:
    ## multiple definition of `TerminalWindowNoMoreActiveWindowsNotification';
    broken = true;
    description = "Terminal emulator for GNUstep";
    homepage = "https://www.nongnu.org/gap/terminal/index.html";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
