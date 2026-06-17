{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  ninja,
  gettext,
  # core deps
  glib,
  cairo,
  librsvg,
  dbus-glib,
  libxml2,
  libGLU,
  curl,
  pcre2,
  libxdmcp,
  libxtst,
  libxcomposite,
  libxrandr,
  libxrender,
  libxinerama,
  gtk3,
  # plug-in deps
  cairo-dock-core,
  pango,
  alsa-lib,
  libetpan,
  gnome-menus,
  libxklavier,
  gvfs,
  upower,
  zeitgeist,
  vte,
  libexif,
  lm_sensors,
  libdbusmenu,
  libdbusmenu-gtk2,
  libdbusmenu-gtk3,
  libindicator,
  libindicator-gtk2,
  libindicator-gtk3,
  libical,
  libpulseaudio,
  fftw,
  lerc,
  icu,
  libayatana-indicator,
  ayatana-ido,
  libxxf86vm,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cairo-dock-plug-ins";
  version = "3.6.1";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = finalAttrs.pname;
    tag = finalAttrs.version;
    hash = "sha256-zGJl66RsXFJmgeV7khY/4ao4gLK0MDJN3gCkbvvwRWA=";
  };

  strictDeps = true;

  # depends on cairo-dock-core's cmake install path weirdness for
  # more of its own
  #patches = [ ./cmake-install.patch ];

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
    libxdmcp
    libxtst
    libxcomposite
    libxrandr
    libxrender
    libxinerama
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
    libxxf86vm
  ];

  # required for finding gio/gdesktopappinfo.h
  env.NIX_CFLAGS_COMPILE = "-I${lib.getDev glib}/include/gio-unix-2.0";

  # one of the most cursed things i've ever needed to do
  env.PKG_CONFIG_PATH = "${lib.getBin cairo-dock-core}/${lib.getBin cairo-dock-core}/lib/pkgconfig/";

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
    # wants to install into cairo-dock-core's path
    broken = true;
    description = "Flexible desktop interface - plug-ins";
    homepage = "https://glx-dock.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
})
