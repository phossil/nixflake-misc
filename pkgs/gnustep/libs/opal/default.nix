{ lib
, fetchFromGitHub
, gnustep
, pkg-config
, cairo
, libjpeg
, libpng
, libtiff
, lcms
}:

gnustep.gsmakeDerivation rec {
  pname = "opal";
  version = "2022-09-03";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libs-opal";
    rev = "9c0a1d76d38ac9a38fb5ee3d0527ec6224147998";
    sha256 = "m2zoaozHpwrDH6c64LKUnZO1WaPRuHz2SisFpy3R+G0=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    gnustep.base
    cairo
    libjpeg
    libpng
    libtiff
    lcms
  ];

  meta = with lib; {
    # depends on corebase, which is broken
    broken = true;
    description = "A drawing library similar to Quartz 2D";
    homepage = "http://goliat.eik.bme.hu/~balaton/gnustep/opal/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
