{
  lib,
  stdenv,
  fetchFromGitHub,
  curl,
}:

stdenv.mkDerivation rec {
  pname = "concord";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "Cogmasters";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-OXR7+F77DAGzT8Sy/s2ayuIvgLLYzc7nD5xmDtiBH/0=";
    fetchSubmodules = true;
  };

  buildInputs = [ curl ];

  postPatch = ''
    # fix prefix path
    substituteInPlace Makefile \
      --replace "/usr/local" "${builtins.placeholder "out"}"
  '';

  meta = with lib; {
    description = "Discord API library written in C99";
    homepage = "https://cogmasters.github.io/concord/";
    maintainers = with maintainers; [ phossil ];
    platforms = with platforms; intersectLists unix littleEndian;
    license = licenses.mit;
  };
}
