{ lib
, fetchFromGitHub
, gnustep
, wine
, pkg-config
}:

gnustep.gsmakeDerivation rec {
  pname = "themes-winuxtheme";
  version = "2022-12-26";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "plugins-themes-WinUXTheme";
    rev = "1d9a37136b8dfc6dcea811ef28defbe52f954d0d";
    sha256 = "iBlcZGZZkbKPNIlkayk/GgDPTM8EczONmRhU457/uJg=";
    fetchSubmodules = true;
  };

  #nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gnustep.base gnustep.gui wine ];

  meta = with lib; {
    # ofc i needed to try mixing two different api's
    # ported from two different os's QwQ
    broken = true;
    description = "Win32 native widgets theme for GNUstep";
    homepage = "http://www.gnustep.org/";
    # copyright information not provided
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
