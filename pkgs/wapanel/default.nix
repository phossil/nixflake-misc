{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkgconfig
, libpulseaudio
, gtk3
, gtk-layer-shell
}:

stdenv.mkDerivation rec {
  pname = "wapanel";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "Firstbober";
    repo = pname;
    rev = version;
    sha256 = "sqVH/XXFIEdB3b19eHj0gqN/hjEltxKisT/UAdMmmXA=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
  ];

  buildInputs = [
    libpulseaudio
    gtk-layer-shell
    gtk3
  ];

  meta = with lib; {
    description =
      "Simple panel/status bar/task bar for your custom stacking Wayland-based desktop";
    homepage = "https://firstbober.github.io/wapanel";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
  };
}
