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
  compiler-rt = fetchurl {
    url = "https://releases.llvm.org/3.7.1/compiler-rt-3.7.1.src.tar.xz";
    sha256 = "10c1mz2q4bdq9bqfgr3dirc6hz1h3sq8573srd5q5lr7m7j6jiwx";
  };
in stdenv.mkDerivation rec {
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
    echo "creating directories for clang and compiler-rt"
    mkdir -p tools/clang
    mkdir -p tools/compiler-rt

    echo "unpacking ${clang} and ${compiler-rt}"
    tar -xf ${clang} --strip-components=1 \
      --directory=tools/clang
    tar -xf ${compiler-rt} --strip-components=1 \
      --directory=tools/compiler-rt

    echo "fixerating cmake"
    substituteInPlace cmake/config-ix.cmake --replace "if(WIN32)" "if(1)"

    chmod -R u+rwX .
  '';

  meta = with lib; {
    # WIP
    broken = true;
    description =
      "A collection of modular and reusable compiler and toolchain technologies - private Etoile instance";
    homepage = "https://llvm.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.ncsa;
  };
}
