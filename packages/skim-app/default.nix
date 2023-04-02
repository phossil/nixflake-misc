{ lib
, fetchsvn
, gnustep
, gnustep-xcode
}:

gnustep.gsmakeDerivation rec {
  pname = "skim-app";
  version = "1.6.15";

  src = fetchsvn {
    url = "http://svn.code.sf.net/p/${pname}/code/trunk/";
    rev = "13356";
    sha256 = "00pmns82d0cq25hgw7h5iqyky6v0vi5rafd2qm1fibzknxq2n88b";
  };

  nativeBuildInputs = [
    gnustep-xcode
  ];

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
  ];

  buildPhase = ''
    runHook preBuild

    ${gnustep-xcode}/bin/buildtool

    runHook postBuild
  '';

  meta = with lib; {
    # broken, gnustep.xcode is WIP
    broken = true;
    description = "PDF reader and note-taker for OS X";
    homepage = "https://skim-app.sourceforge.io/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
  };
}
