{ stdenv
, lib
, fetchFromGitHub
, makeWrapper
, roswell
, sbclPackages
, openssl
, ncurses
, SDL2
}:

stdenv.mkDerivation rec {
  pname = "lem";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "lem-project";
    repo = pname;
    rev = "v${version}";
    sha256 = "SR17L8T0aejrIVqgAsUE5clBpSdkc4F5xPF+7PslpL4=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ makeWrapper roswell ];

  buildInputs = [
    openssl
    ncurses
    SDL2
  ] ++ (with sbclPackages; [
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
    ros follow-dependency=t install ./lem.asd

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
