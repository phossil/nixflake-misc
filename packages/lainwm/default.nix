{ lib
, stdenv
, fetchurl
, xorg
, gettext
, freetype
}:

stdenv.mkDerivation rec {
  pname = "LainWM";
  version = "1.3Alpha";

  src = fetchurl {
    url = "mirror://sourceforge/lainos/${pname}-${version}.tar.bz2";
    sha256 = "1qwnkky7d5xdl9nsjqnam031digilahsx5fg12zg9qq73drlky85";
  };

  buildInputs = [
    freetype
  ];

  meta = with lib; {
    # marked as broken bc old configure script
    broken = true;
    homepage = "https://lainos.sourceforge.net/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
