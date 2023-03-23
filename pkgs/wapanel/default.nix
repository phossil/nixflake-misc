{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkgconfig
, gtk3
, gtk-layer-shell
, libpulseaudio
, wayland-protocols
, wayland
, wayland-scanner
, xdg-utils
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
    gtk-layer-shell
    gtk3
    libpulseaudio    
    wayland-protocols
    wayland
    wayland-scanner
    xdg-utils
  ];

  postPatch = ''
    # Fix XDG paths
    substituteInPlace thirdparty/xdgpp/xdg.hpp \
      --replace "/usr/local/share\", \"/usr/share" "/run/current-system/sw/share" \
      --replace "/etc/xdg" "/run/current-system/sw/etc/xdg"

    # Fix XDG paths in task switcher
    substituteInPlace src/applets/task-switcher/task_switcher.cc \
      --replace "/usr/share/applications/\", \"/usr/local/share/applications/" \
      "/run/current-system/sw/share/applications/"
  '';

  meta = with lib; {
    description =
      "Simple panel/status bar/task bar for your custom stacking Wayland-based desktop";
    homepage = "https://firstbober.github.io/wapanel";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
  };
}
