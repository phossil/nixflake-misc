{ lib
, stdenv
, fetchFromGitHub
, sbcl
, libffi
, SDL2
, SDL2_ttf
, SDL2_image
, ncurses
, openssl
}:

stdenv.mkDerivation rec {
  pname = "lem";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "lem-project";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-aMPyeOXyFSxhh75eiAwMStLc2fO1Dwi2lQsuH0IYMd0=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    sbcl
  ];

  buildInputs = [
	  libffi
	  SDL2
	  SDL2_ttf
	  SDL2_image
	  ncurses
	  openssl
  ];

  env.LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;

  buildPhase = ''
    ${sbcl}/bin/sbcl --noinform --no-sysinit --no-userinit --eval \
      '(qlot:install #P"${src}")'
  '';
  
  installPhase = ''
    echo meow
  '';

  meta = with lib; {
    # beyond brokem, too eepy q q
    broken = true;
    description = "crazy cool ide written in common lisp B)";
    homepage = "http://lem-project.github.io/";
    mainProgram = "lem";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
