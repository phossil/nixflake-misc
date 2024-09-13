{
  lib,
  stdenv,
  fetchFromGitHub,
  sbcl,
  sbclPackages,
  libffi,
  SDL2,
  SDL2_ttf,
  SDL2_image,
  ncurses,
  openssl,
  writeText,
}:

let
  sbcl' = sbcl.withPackages (ps: with ps; [ sbclPackages.qlot ]);
in
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

  strictDeps = true;

  nativeBuildInputs = [ sbcl' ];

  buildInputs = [
    libffi
    SDL2
    SDL2_ttf
    SDL2_image
    ncurses
    openssl
  ];

  env.LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;

  qlotBuild = writeText "qlot-build.lisp" ''
    (load (sb-ext:posix-getenv "ASDF"))
    (asdf:load-system 'qlot)
    (qlot:install #P"/build/source")
  '';

  buildPhase = ''
    ${sbcl'}/bin/sbcl --noinform --no-sysinit --no-userinit --load ${qlotBuild}
  '';

  installPhase = ''
    echo meow
  '';

  meta = with lib; {
    ## fails with error:
    # Running phase: buildPhase
    # Installing Quicklisp to /build/source/.qlot/ ...
    # While evaluating the form starting at line 3, column 0
    #   of #P"/nix/store/axry9cbnx1g5hzs2yz4rs8321yqhbl35-qlot-build.lisp":
    # debugger invoked on a PACKAGE-DOES-NOT-EXIST in thread
    # #<THREAD tid=33 "main thread" RUNNING {10003E8143}>:
    #   The name "QL-HTTP" does not designate any package.
    broken = true;
    description = "Common Lisp editor and IDE";
    homepage = "http://lem-project.github.io/";
    mainProgram = "lem";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
