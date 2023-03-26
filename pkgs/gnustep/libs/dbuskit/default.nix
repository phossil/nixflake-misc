{ lib
, fetchFromGitHub
, gnustep
, dbus
, libclang
, pkg-config
}:

gnustep.gsmakeDerivation rec {
  pname = "dbuskit";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libs-dbuskit";
    rev = "c9db6a1c2a102529aefbf6164c64adae8c073a5d";
    sha256 = "QpvfDN4TApwfTFwQeY1L86fXnb6t68blieGd94o5qGM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gnustep.base gnustep.gui dbus libclang ];

  meta = with lib; {
    # libDBusKit.so: undefined reference to `GS_GC_HIDE'
    broken = true;
    description = "DBus bindings for Objective-C applications";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
