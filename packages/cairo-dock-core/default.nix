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
  version = "3.5.1";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = version;
    hash = "sha256-x7s7xmNF9nfJLq/u8ageaadBNHlxeekQ1JzfLugYJQ8=";
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
