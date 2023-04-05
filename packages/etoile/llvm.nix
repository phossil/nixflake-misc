{ lib
, stdenv
, fetchurl
, cmake
, python2
, fetchpatch
}:
let
  clang = fetchurl {
    url = "https://releases.llvm.org/3.3/cfe-3.3.src.tar.gz";
    sha256 = "15mrvw43s4frk1j49qr4v5viq68h8qlf10qs6ghd6mrsmgj5vddi";
  };
in
stdenv.mkDerivation rec {
  pname = "llvm";
  version = "3.3";

  src = fetchurl {
    url = "https://releases.llvm.org/${version}/llvm-${version}.src.tar.gz";
    sha256 = "0y3mfbb5qzcpw3v5qncn69x1hdrrrfirgs82ypi2annhf0g6nxk8";
  };

  unpackPhase = ''
    echo "Unpacking LLVM"
    unpackFile ${src}
    mv llvm-${version}.src llvm
    sourceRoot=$PWD/llvm

    echo "Unpacking Clang"
    unpackFile ${clang}
    mv cfe-${version}.src llvm/tools/clang
  '';

  nativeBuildInputs = [
    cmake
    python2
  ];

  meta = with lib; {
    description =
      "A collection of modular and reusable compiler and toolchain technologies - private Etoile instance";
    homepage = "https://llvm.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.ncsa;
  };
}
