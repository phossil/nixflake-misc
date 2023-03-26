{ lib
, fetchFromGitHub
, gnustep
, icu
, tzdata
}:

gnustep.gsmakeDerivation rec {
  pname = "corebase";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libs-corebase";
    rev = "52d400bb294ad75ac2fe58cf593a0a98f069e855";
    sha256 = "tdC92eu0VFQmXXnJ08jbmuGmbBmXGMKYDZz+fGU0cDc=";
    fetchSubmodules = true;
  };

  buildInputs = [ gnustep.base icu ];

  meta = with lib; {
    # how do i give it time zonedata ?
    broken = true;
    description =
      "A library of general-purpose, non-graphical C object for GNUstep";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
