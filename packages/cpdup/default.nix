{ lib
, stdenv
, fetchFromGitHub
, pkgconfig
, libbsd
, openssl
}:

stdenv.mkDerivation rec {
  pname = "cpdup";
  version = "1.22";

  src = fetchFromGitHub {
    owner = "DragonFlyBSD";
    repo = pname;
    rev = "v${version}";
    sha256 = "do4Fs002NTajMZIa4CTj3EfbhWxu6N3dmaIRk1BZKdo=";
  };

  nativeBuildInputs = [
    pkgconfig
  ];

  buildInputs = [
    libbsd
    openssl
  ];

  meta = with lib; {
    # im too lazy to make a proper comment
    broken = true;
    description = "Filesystem mirroring utility from DragonFlyBSD";
    homepage = "https://github.com/DragonFlyBSD/cpdup";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.bsd3;
  };
}
