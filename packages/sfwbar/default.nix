{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, json_c
, gtk3
, glib
, gtk-layer-shell
, libpulseaudio
, libmpdclient
, libxkbcommon
}:

stdenv.mkDerivation rec {
  pname = "sfwbar";
  version = "1.0_beta10";

  src = fetchFromGitHub {
    owner = "LBCrion";
    repo = pname;
    rev = "v${version}";
    sha256 = "WG2J0czjB7RstwKPy3C4D57P9Xh8xlSEPh6g2bDq8OA=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    json_c
    gtk-layer-shell
    gtk3
    libpulseaudio
    libmpdclient
    libxkbcommon
  ];

  mesonFlags = [
    # TODO: https://github.com/NixOS/nixpkgs/issues/36468
    "-Dc_args=-I${glib.dev}/include/gio-unix-2.0"
  ];

  meta = with lib; {
    description = "Sway Floating Window Bar";
    homepage = "https://github.com/LBCrion/sfwbar";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Only;
  };
}
