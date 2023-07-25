{ stdenv
, lib
, fetchFromGitHub
, requireFile
, unzip
, desktop-file-utils
, fftw
, glu
, gsfonts
, hicolor-icon-theme
, jack2
, liblo
, liblrdf
, libmpc
, libsndfile
, python2
, qt5-svg
, qt5-webkit
, qt5-x11extras
, speex
, ttf-bitstream-vera
, ttf-croscore
, ttf-lato
, boost
, cmake
, ladspa
, libxcursor
, libxinerama
, libxkbfile
, libxrandr
, llvm
, qt5-tools
}:

stdenv.mkDerivation rec {
  pname = "radium";
  version = "6.9.94";
  #version = "7.1.92";

  src = fetchFromGitHub {
    owner = "kmatheussen";
    repo = pname;
    rev = "v${version}";
    sha256 = "1nj6qydb41zbjjp8qyy8dxhs5wghk366n61r72cm89jxdjyr38xg";
  };

  vst-sdk = stdenv.mkDerivation rec {
    name = "vstsdk368_08_11_2017_build_121";
    src = requireFile {
      name = "${name}.zip";
      url = "http://www.steinberg.net/en/company/developers.html";
      sha256 = "e0f235d8826d70f1ae0ae5929cd198acae1ecff74612fde5c60cbfb45c2f4a70";
    };
    nativeBuildInputs = [ unzip ];
    installPhase = "cp -r . $out";
    meta.license = lib.licenses.unfree;
  };

  nativeBuildInputs = [
    boost
    cmake
    ladspa
    libxcursor
    libxinerama
    libxkbfile
    libxrandr
    llvm
    qt5-tools
  ];

  buildInputs = [
    desktop-file-utils
    fftw
    glu
    gsfonts
    hicolor-icon-theme
    jack2
    liblo
    liblrdf
    libmpc
    libsndfile
    python2
    qt5-svg
    qt5-webkit
    qt5-x11extras
    speex
    ttf-bitstream-vera
    ttf-croscore
    ttf-lato
  ];

  cmakeFlags = [ "-DVSTSDK_PATH=${vst-sdk}/VST2_SDK" ];

  NIX_LDFLAGS = ''
    -lfftw3_threads -lfftw3f_threads
  '';

  postPatch = ''
    chmod +x scripts/meson-post-install.sh
    patchShebangs ext/sh-manpage-completions/run.sh scripts/generic_guile_wrap.sh \
      scripts/meson-post-install.sh tools/check_have_unlimited_memlock.sh
  '';

  meta = with lib; {
  	# broken am lazy
    broken = true;
    homepage = "https://www.zrythm.org";
    description = "highly automated and intuitive digital audio workstation";
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
 
