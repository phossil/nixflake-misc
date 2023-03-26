{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "terminal";
  version = "0.9.9";

  src = fetchurl {
    url = "http://savannah.nongnu.org/download/gap/Terminal-${version}.tar.gz";
    sha256 = "1s90q81wycrp6ngw4n0wal7c5gkk97g2q0c0q3lcs45xrnz1py17";
  };

  buildInputs = with gnustep; [ base back gui ];

  postPatch = ''
    echo "Apply fix as seen in Gentoo"
    # https://gitweb.gentoo.org/repo/gentoo.git/tree/gnustep-apps/terminal/files/terminal-0.9.9-fno-common.patch?id=ede594fc156724728e8786399c04a88ed32def63
    substituteInPlace TerminalWindow.h \
      --replace "NSString *TerminalWindowNoMoreActiveWindowsNotification;" \
      "extern NSString *TerminalWindowNoMoreActiveWindowsNotification;"
  '';

  meta = with lib; {
    description = "Terminal emulator for GNUstep";
    homepage = "https://www.nongnu.org/gap/terminal/index.html";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
