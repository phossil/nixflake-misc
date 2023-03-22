{ lib
, stdenv
, fetchurl
, cmake
, python2
, fetchpatch
}:

let
  clang = fetchurl {
    url = "https://releases.llvm.org/3.7.1/cfe-3.7.1.src.tar.xz";
    sha256 = "0x065d0w9b51xvdjxwfzjxng0gzpbx45fgiaxpap45ragi61dqjn";
  };
in
stdenv.mkDerivation rec {
  pname = "llvm";
  version = "3.7.1";

  src = fetchurl {
    url = "https://releases.llvm.org/3.7.1/llvm-${version}.src.tar.xz";
    sha256 = "1masakdp9g2dan1yrazg7md5am2vacbkb3nahb3dchpc1knr8xxy";
  };

  nativeBuildInputs = [
    cmake
    python2
  ];

  sourceRoot = "llvm-3.7.1.src";

  prePatch = ''
    echo "creating directory for clang"
    mkdir -p tools/clang
    mkdir -p tools/compiler-rt

    echo "unpacking ${clang}"
    tar -xf ${clang} --strip-components=1 \
      --directory=tools/clang

    chmod -R u+rwX .
  '';

  enableParallelBuilding = true;

  outputs = [ "dev" "out" ];

  meta = with lib; {
    # WIP
    #broken = true;
    description =
      "A collection of modular and reusable compiler and toolchain technologies - private Etoile instance";
    homepage = "https://llvm.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.ncsa;
  };
}
