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
  version = "3.5.2";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = version;
    hash = "sha256-WFuFreDkTxPTms8lwzWo9Cc10FEoLHsisVAxySgnNEo=";
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
    # builds successfully but cannot find resource files
    broken = true;
    description = "Flexible desktop interface";
    homepage = "https://glx-dock.org/";
    mainProgram = "cairo-dock";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
