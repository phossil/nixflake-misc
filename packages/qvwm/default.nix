{
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  bison,
  flex,
  libxpm,
  libsm,
  libxscrnsaver,
  libice,
  libxext,
  libxrender,
  alsa-lib,
  audiofile,
  imlib2,
  gettext,
  writeText,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "qvwm";
  version = "1.1.12";

  src = fetchFromGitHub {
    owner = "asveikau";
    repo = finalAttrs.pname;
    rev = "a0b181ef52deb221c8ea4219755e3279278af3fd";
    sha256 = "Bq0N0RslBvjnpWfulWvlVmf7CewPQDMPIKC+BKAxQZA=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    bison
    flex
    gettext
  ];

  buildInputs = [
    libxpm
    libsm
    libxscrnsaver
    libice
    libxext
    libxrender
    alsa-lib
    audiofile
    imlib2
  ];

  configureFlags = [
    "--enable-rmtcmd"
    "--enable-xsmp"
    "--enable-ss"
    "--with-alsa=${lib.getLib alsa-lib}/lib/libasound.so"
    "--without-esd"
  ];

  xsessionFile = writeText "qvwm.desktop" ''
    [Desktop Entry]
    Type=Xsession
    Name=QvWM
    TryExec=@out@/bin/qvwm
    Exec=@out@/bin/qvwm
    Comment=Windows 9x lookalike window manager
  '';

  # move xsession file to appropriate path
  postInstall = ''
    mkdir -p $out/share/xsessions
    substitute ${finalAttrs.xsessionFile} $out/share/xsessions/qvwm.desktop --subst-var out
  '';

  passthru.providedSessions = [ "qvwm" ];

  meta = with lib; {
    description = "'Windows Classic'-like X11 window manager";
    homepage = "https://github.com/asveikau/qvwm";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl2;
    mainProgram = "qvwm";
  };
})
