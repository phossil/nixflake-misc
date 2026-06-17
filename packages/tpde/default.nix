{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  clang,
  llvm,
  python3,
  lit,
  libffi,
  zlib,
  libxml2,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "tpde";
  version = "0-unstable-2026-03-30";

  src = fetchFromGitHub {
    owner = "tpde2";
    repo = finalAttrs.pname;
    rev = "338d41890e424b058e2053b6a5787e1348e3dd57";
    hash = "sha256-mCzaSE3bqg5Ap7KxDIvccEiuLWlXNTw2AaWG/Z+iFqw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    ninja
    clang
    python3
    lit
  ];

  buildInputs = [
    llvm
    libffi
    zlib
    libxml2
  ];

  hardeningDisable = [
    # `glibc-2.42-61-dev/include/features.h:435:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]`
    "fortify"
  ];

  meta = with lib; {
    description = "Compiler framework for faster build-times";
    homepage = "https://docs.tpde.org/";
    maintainers = with maintainers; [ phossil ];
    # the documentation states "ELF-based x86-64 and AArch64 (Armv8.1) platforms"
    platforms = with platforms; intersectLists unix (x86_64 ++ aarch64);
    license = with licenses; [
      (WITH asl20 llvm-exception)
      cc0
    ];
  };
})
