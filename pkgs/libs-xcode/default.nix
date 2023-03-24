{ lib
, fetchFromGitHub
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "libs-xcode";
  version = "2023-03-20";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = pname;
    rev = "ca17d05b9b9268dfe8bc3137839725ac144036d0";
    sha256 = "VT/Viekc3Tu8jKikd8pvMSQFvl+ho5QzyKSWKyPo2eA=";
    fetchSubmodules = true;
  };

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
  ];

  meta = with lib; {
    description = "GNUstep library for building Xcode projects";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
