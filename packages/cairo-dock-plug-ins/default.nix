{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, ninja
, gettext
  # core deps
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
  # plug-in deps
, cairo-dock-core
, pango
, alsa-lib
, libetpan
, gnome-menus
, libxklavier
, gvfs
, upower
, zeitgeist
, vte
, libexif
, lm_sensors
, libdbusmenu
, libdbusmenu-gtk2
, libdbusmenu-gtk3
, libindicator
, libindicator-gtk2
, libindicator-gtk3
, libical
, libpulseaudio
, fftw
, lerc
, icu
, libayatana-indicator
, ayatana-ido
}:

stdenv.mkDerivation rec {
  pname = "cairo-dock-plug-ins";
  version = "3.5.0-unstable-2024-05-01";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = "9901f7d9d59657363580b75766f7d5e7f23b6388";
    hash = "sha256-jguQIhqQwXfwb9v5A82B6dual4EJd3x11UEbHdf1VQE=";
  };

  strictDeps = true;

  # depends on cairo-dock-core's cmake install path weirdness for
  # more of its own
  patches = [ ./cmake-install.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    gettext
  ];

  buildInputs = [
    # core deps
    glib
    cairo
    librsvg
    dbus-glib
    libxml2
    libGLU
    curl
    pcre2
    gtk3
    # plug-in deps
    cairo-dock-core
    pango
    alsa-lib
    libetpan
    gnome-menus
    libxklavier
    gvfs
    upower
    zeitgeist
    vte
    libexif
    lm_sensors
    libdbusmenu
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    libindicator
    libindicator-gtk2
    libindicator-gtk3
    libical
    libpulseaudio
    fftw
    lerc
    icu
    libayatana-indicator
    ayatana-ido
  ] ++ (with xorg; [
    # core deps
    libXdmcp
    libXtst
    libXcomposite
    libXrandr
    libXrender
    libXinerama
    # plug-in deps
    libXxf86vm
  ]);

  cmakeFlags = [
    # unstable features
    "-Denable-global-menu=True"
    "-Denable-network-monitor=True"
    # language interfaces
    "-Denable-python-interface=False"
    "-Denable-ruby-interface=False"
    "-Denable-vala-interface=False"
    "-Denable-mono-interface=False"
  ];

  meta = with lib; {
    description = "Flexible desktop interface - plug-ins";
    homepage = "https://glx-dock.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
