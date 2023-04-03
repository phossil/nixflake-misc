{ lib
, fetchFromGitHub
, gnustep
, dbus
, libclang
, pkg-config
}:

gnustep.gsmakeDerivation rec {
  pname = "dbuskit";
  version = "2021-01-19";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libs-dbuskit";
    rev = "4dc9b56216e46e0e385b976b0605b965509ebbbd";
    sha256 = "mZfN3FuMtZx4Zc9Flut5HKTWKcCIPLQh40TvhhNy3xA=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gnustep.base gnustep.gui dbus libclang ];

  postPatch = ''
    # the gnustep build system expects all additional
    # make files to exist in gnustep.make
    substituteInPlace Bundles/DKUserNotification/GNUmakefile \
      --replace "\$(BASE_MAKEFILE)" \
      "${gnustep.base}/share/GNUstep/Makefiles/Additional/base.make"
  '';

  meta = with lib; {
    description = "DBus bindings for Objective-C applications";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
