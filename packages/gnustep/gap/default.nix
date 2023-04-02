{ lib
, fetchFromGitHub
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "gap";
  version = "2023-02-16";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = pname;
    rev = "8918842655b5a6bbd19ad8c71f7dacf3a1776782";
    sha256 = "X2YslO6PEnCC4Id4Qg38gdTnhi6YN4Tj9a3tsQ/FXtU=";
    fetchSubmodules = true;
  };

  buildInputs = with gnustep; [
    base
    back
    gui
  ];

  meta = with lib; {
    # marked as broken bc build fails (WIP)
    broken = true;
    description = "GNUstep Application Project";
    homepage = "https://github.com/gnustep/gap";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
