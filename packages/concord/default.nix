{
  lib,
  stdenv,
  fetchFromGitHub,
  curl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "concord";
  version = "2.4.0-unstable-2026-05-02";

  src = fetchFromGitHub {
    owner = "Cogmasters";
    repo = finalAttrs.pname;
    rev = "ff3d471d8612447e64b688b07e628ed6df4590a7";
    hash = "sha256-bR91MdszuJbFqScCwVZSc2bZMEpvlx7kUFTztGjcFaY=";
    fetchSubmodules = true;
  };

  buildInputs = [ curl ];

  makeFlags = [
    # prefix path defaults to /usr/local
    "PREFIX=${builtins.placeholder "out"}"
    "SHAREDIR=${builtins.placeholder "out"}/share"
    # defaults to static library instead of shared
    "shared"
  ];

  meta = with lib; {
    description = "Discord API library written in C99";
    homepage = "https://cogmasters.github.io/concord/";
    maintainers = with maintainers; [ phossil ];
    platforms = with platforms; intersectLists unix littleEndian;
    license = licenses.mit;
  };
})
