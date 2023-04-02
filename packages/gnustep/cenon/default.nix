{ lib
, fetchurl
, gnustep
}:

let
  CenonLibrary = fetchurl {
    url = "http://cenon.download/source/CenonLibrary-4.0.0-1.tar.bz2";
    sha256 = "0i5vij1gi4l3v6656dzlwjv02d5549lqznfxxqzdjh2v9cd36adk";
  };
in
gnustep.gsmakeDerivation rec {
  pname = "cenon";
  version = "4.0.2";

  src = fetchurl {
    url = "http://cenon.download/source/Cenon-${version}.tar.bz2";
    sha256 = "0bzbn2kjzbjczp6ss8rsy0vj4p9x589q385p9qrccrrrkxvzya6j";
  };

  buildInputs = with gnustep; [ base back gui ];

  # move CenonLibrary file to appropriate path
  # Cenon wants one of "/usr/GNUstep/Local/Library" or
  # "/Library/Application Support"
  postUnpack = ''
    echo "Unpacking CenonLibrary"
    mkdir -p $out/lib/GNUstep/Libraries/
    cd $out/lib/GNUstep/Libraries/
    unpackFile ${CenonLibrary}
    cd /build
  '';

  meta = with lib; {
    # someone help me how do i install the library aaaaa
    broken = true;
    description = "Graphics software with style";
    homepage = "http://www.cenon.info/";
    # the license is referred to as the:
    # vhf PUBLIC LICENSE (vhfPL)
    # Version 1.1, February 2004
    license = licenses.free;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
