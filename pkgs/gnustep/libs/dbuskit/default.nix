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
    rev = version;
    sha256 = "QpvfDN4TApwfTFwQeY1L86fXnb6t68blieGd94o5qGM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gnustep.base gnustep.gui dbus libclang ];

  postPatch = ''
    # the garbage collector no longer exists  
    substituteInPlace Source/DKNotificationCenter.m \
      --replace "GS_GC_HIDE(anObserver)" "anObserver" \
      --replace "GS_GC_UNHIDE(observer)" "observer" \
  '';

  meta = with lib; {
    description = "DBus bindings for Objective-C applications";
    homepage = "http://www.gnustep.org/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
