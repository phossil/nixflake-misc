{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "steptalk";
  version = "0.10.0";

  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/libs/StepTalk-${version}.tar.gz";
    sha256 = "05f1vxpf7898smxgap4zsmny5aspba7l0y1gxcy4ngab21yskzci";
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    # requires gnustep renaissance, probably ?
    broken = true;
    description = "the official GNUstep scripting framework";
    homepage = "https://gnustep.github.io/experience/StepTalk.html";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
