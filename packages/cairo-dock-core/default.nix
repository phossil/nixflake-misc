{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, gettext
, glib
, cairo
, librsvg
, dbus-glib
, libxml2
, libGLU
, curl
, pcre2
, xorg
, gtk3
}:

stdenv.mkDerivation rec {
  pname = "cairo-dock-core";
  version = "3.5.0";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = version;
    hash = "sha256-NqRxFlcQtdJ+o5io6LXwTRZCxFI2wWDOoQn7s9or49s=";
  };

  strictDeps = true;

  patches = [ ./cmake-install.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
    gettext
  ];

  buildInputs = [
    glib
    cairo
    librsvg
    dbus-glib
    libxml2
    libGLU
    curl
    pcre2
    gtk3
  ] ++ (with xorg; [
    libXdmcp
    libXtst
    libXcomposite
    libXrandr
    libXrender
    libXinerama
  ]);

  cmakeFlags = [
    "-Denable-egl-support=True" # acceleration in wayland
    #"-Denable-desktop-manager=True" # fails with below error
    # CMake Error at data/desktop-manager/gnome-session-3.36/cmake_install.cmake:54 (file):
    #  file cannot create directory: /var/empty/share/xsessions.  Maybe need
    #  administrative privileges.
  ];

  meta = with lib; {
    description = "Flexible desktop interface";
    homepage = "https://glx-dock.org/";
    mainProgram = "cairo-dock";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
