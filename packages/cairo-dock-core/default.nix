{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  ninja,
  gettext,
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
  wayland,
  gtk-layer-shell,
  json_c,
  kdePackages,
  systemdLibs,
  libsysprof-capture,
  wayland-scanner,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cairo-dock-core";
  version = "3.6.1";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = finalAttrs.pname;
    tag = finalAttrs.version;
    hash = "sha256-tki0XmcwPNngcM5O1woCfFw01lcvD5FuV+pn7X/iWs0=";
  };

  strictDeps = true;

  # fixes some custom install path variables
  #patches = [ ./cmake-install.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    gettext
    kdePackages.extra-cmake-modules
    wayland-scanner
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
    wayland
    gtk-layer-shell
    json_c
    systemdLibs
    libsysprof-capture
    libxdmcp
    libxtst
    libxcomposite
    libxrandr
    libxrender
    libxinerama
  ];

  # required for finding gio/gdesktopappinfo.h
  env.NIX_CFLAGS_COMPILE = "-I${lib.getDev glib}/include/gio-unix-2.0";

  cmakeFlags = [ "-Denable-systemd-service=True" ];

  meta = with lib; {
    description = "Flexible desktop interface";
    homepage = "https://glx-dock.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
    mainProgram = "cairo-dock";
  };
})
