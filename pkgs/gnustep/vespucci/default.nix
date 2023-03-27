{ lib
, fetchFromGitHub
, gnustep
, simplewebkit
}:

gnustep.gsmakeDerivation rec {
  pname = "vespucci";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "phossil";
    repo = "Vespucci";
    rev = "801e56291215d59d1923e4b5d607854e9bcefdbc";
    sha256 = "1v7IzqUkOH9Gtekz6NMDEgRJcx96bzrVZx2/kH9vHeY=";
    fetchSubmodules = true;
  };

  buildInputs = with gnustep; [ base back gui ] ++ [ simplewebkit ];

  meta = with lib; {
    description = "Vespucci is a navigator for the World Wide Web";
    homepage = "http://gap.nongnu.org/vespucci/index.html";
    #license = licenses.gpl2Plus;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
