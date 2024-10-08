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
  nlohmann_json,
  extra-cmake-modules,
  systemdLibs,
}:

stdenv.mkDerivation rec {
  pname = "cairo-dock-core";
  version = "3.5.0-unstable-2024-05-24";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = "13fb1516bc269debe7d7dfc1c67aae7acde27423";
    hash = "sha256-OIy1jF3+s0PWEn3zQbAO1DIToijCqcO/HkvYNhcOsOs=";
  };

  strictDeps = true;

  # fixes some custom install path variables
  patches = [ ./cmake-install.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    gettext
    extra-cmake-modules
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
      nlohmann_json
      systemdLibs
    ]
    ++ (with xorg; [
      libXdmcp
      libXtst
      libXcomposite
      libXrandr
      libXrender
      libXinerama
    ]);

  env.ECM_DIR = "${extra-cmake-modules}/share/ECM";

  meta = with lib; {
    description = "Flexible desktop interface";
    homepage = "https://glx-dock.org/";
    mainProgram = "cairo-dock";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
