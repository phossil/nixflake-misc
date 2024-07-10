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
  #, libetpan # mail
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
  #, gnome2 # old gnome integration
  #, webkitgtk # weblets
  # language bindings
, python3
, ruby
, vala
  #, mono # mono interface
  #, gtk-sharp-3_0 # mono interface
}:

stdenv.mkDerivation rec {
  pname = "cairo-dock-plug-ins";
  version = "3.5.0";

  src = fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = pname;
    rev = version;
    hash = "sha256-g7bnbSJUL5r/lM3rGxLEd+Td7IGB4anz1h1IRHn283I=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    gettext
    # language bindings
    python3
    ruby
    vala
    #mono # mono interface
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
    #libetpan # mail
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
    #gnome2.gvfs # old gnome integration
    #gnome2.libgnomeui # old gnome integration
    #webkitgtk # weblets
    # language bindings
    #gtk-sharp-3_0 # mono interface
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
    "-Denable-mail=False" # libetpan-config not found
    "-Denable-weblets=False" # webkitgtk not found
    "-Denable-mono-interface=False" # missing deps
    "-Denable-global-menu=True"
    "-Denable-network-monitor=True"
    "-Denable-old-gnome-integration=False" # causes build failure
  ];

  meta = with lib; {
    ## fails with following error:
    # [1/2] Install the project...
    # -- Install configuration: "Release"
    # CMake Error at shared-files/images/cmake_install.cmake:46 (file):
    #   file cannot create directory:
    #   /nix/store/0wp2d6kaskx7h2lm1v4672n9k1jpck6v-cairo-dock-core-3.5.0/share/cairo-dock/plug-ins/shared-files/images.
    #   Maybe need administrative privileges.
    # Call Stack (most recent call first):
    #   shared-files/cmake_install.cmake:47 (include)
    #   cmake_install.cmake:47 (include)
    # FAILED: CMakeFiles/install.util
    # cd /build/source/build && /nix/store/ll2b6cslly4v30im7qk34f9y21ziiz1i-cmake-3.29.6/bin/cmake -P cmake_install.cmake
    # ninja: build stopped: subcommand failed.
    broken = true;
    description = "Flexible desktop interface - plug-ins";
    homepage = "https://glx-dock.org/";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
