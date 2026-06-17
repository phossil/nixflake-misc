{
  lib,
  stdenv,
  fetchFromGitHub,
  curl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "concord";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "Cogmasters";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-OXR7+F77DAGzT8Sy/s2ayuIvgLLYzc7nD5xmDtiBH/0=";
    fetchSubmodules = true;
  };

  buildInputs = [ curl ];

  makeFlags = [
    # prefix path defaults to /usr/local
    "PREFIX=${builtins.placeholder "out"}"
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
