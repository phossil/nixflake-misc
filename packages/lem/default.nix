{ stdenv
, lib
, fetchFromGitHub
, makeWrapper
, roswell
, lispPackages_new
, openssl
, ncurses
}:

stdenv.mkDerivation rec {
  pname = "lem";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "lem-project";
    repo = pname;
    rev = "v${version}";
    sha256 = "n+AyoGSKuVi8w9Z2pOWL8JNI2Jif6KCjLAw4+ubdJhw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ makeWrapper roswell ];

  buildInputs = [
    openssl
    ncurses
  ] ++ (with lispPackages_new.sbclPackages; [
    alexandria
    trivial-gray-streams
    trivial-types
    cl-ppcre
    inquisitor
    babel
    bordeaux-threads
    yason
    log4cl
    split-sequence
  ]);

  installPhase = ''
    ros follow-dependency=t install lem-project/lem

    mkdir -p $out/bin
    makeWrapper $src/bin/lem $out/bin/lem \
      --argv0 lem "''${makeWrapperArgs[@]}"
  '';

  checkPhase = ''
    $out/bin/lem
  '';

  meta = with lib; {
    # I have absolutely no idea how to package Common Lisp software
    broken = true;
    description = "Common Lisp editor/IDE with high expansibility ";
    homepage = "https://github.com/lem-project/lem";
    license = licenses.mit;
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.all;
  };
}
