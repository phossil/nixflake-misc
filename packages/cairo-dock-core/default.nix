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
  xorg,
  gtk3,
  wayland,
  gtk-layer-shell,
  json_c,
  extra-cmake-modules,
  systemdLibs,
  libsysprof-capture,
  wayland-scanner,
}:

stdenv.mkDerivation rec {
  pname = "cairo-dock-core";
  version = "3.6.1";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = version;
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
    extra-cmake-modules
    wayland-scanner
  ];

  buildInputs =
    [
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
    ]
    ++ (with xorg; [
      libXdmcp
      libXtst
      libXcomposite
      libXrandr
      libXrender
      libXinerama
    ]);

  # required for finding gio/gdesktopappinfo.h
  env.NIX_CFLAGS_COMPILE = "-I${lib.getDev glib}/include/gio-unix-2.0";

  cmakeFlags = [ "-Denable-systemd-service=True" ];

  meta = with lib; {
    description = "Flexible desktop interface";
    homepage = "https://glx-dock.org/";
    mainProgram = "cairo-dock";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
