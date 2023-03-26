{ lib
, fetchurl
, gnustep
}:

gnustep.gsmakeDerivation rec {
  pname = "ftp";
  version = "0.6";

  src = fetchurl {
    url = "http://savannah.nongnu.org/download/gap/FTP-${version}.tar.gz";
    sha256 = "046nqh97ak23fslccvbpkz4x77hgbn8807zdhfhzwdrz18flr27r";
  };

  buildInputs = with gnustep; [ base back gui ];

  meta = with lib; {
    description = "FTP client for GNUstep";
    homepage = "https://gap.nongnu.org/ftp/";
    # i did not see a license/copying file
    #license = licenses.gpl2Only;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
