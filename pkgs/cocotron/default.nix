{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "cocotron";
  version = "2015-11-05";

  src = fetchFromGitHub {
    owner = "cjwl";
    repo = pname;
    rev = "9cda7d719428a8ff940b134e391e511104ee0b5d";
    sha256 = "S14iaCsLPuXF7tIrc68V5Hmg6aVHGk9MXO3wq3Zn1LY=";
    fetchSubmodules = true;
  };

  meta = with lib; {
    # how do i build this without hardcoding the target triples TuT
    broken = true;
    description =
      "A developer SDK which implements a cross-platform Objective-C API";
    homepage = "https://www.cocotron.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}