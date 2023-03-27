{ lib
, fetchFromGitHub
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "simplewebkit";
  version = "2020-05-30";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libs-simplewebkit";
    rev = "fb87093c90f7c39a4a06aba8ea84d74ee33b26dd";
    sha256 = "jXgcHweJHCl6gBPWj1LYuY1VSIxr42QhmVqgkz+0+rA=";
    fetchSubmodules = true;
  };

  buildInputs = with gnustep; [ base gui ];

  meta = with lib; {
    description =
      "Lightweight implementation of a subset of WebKit APIs using AppKit";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
