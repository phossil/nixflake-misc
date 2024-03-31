{ lib
, clangStdenv
, fetchFromGitHub
, gnustep
, SDL
, SDL_image
, SDL_mixer
, nspr
, openal
, espeak-classic
, libGLU
, libogg
, libvorbis
, pkg-config
}:

clangStdenv.mkDerivation rec {
  pname = "oolite";
  version = "1.90";

  src = fetchFromGitHub {
    owner = "OoliteProject";
    repo = pname;
    rev = version;
    hash = "sha256-fCYYZR8oXd5z/L7je0fFIXTXjYk/nLcrwm+AsV/Ncbo=";
    fetchSubmodules = true;
  };

  strictDeps = true;

  nativeBuildInputs = [
    gnustep.make
    gnustep.wrapGNUstepAppsHook
  ];

  buildInputs = [
    gnustep.base
    gnustep.gui
    gnustep.back
    SDL
    SDL_image
    SDL_mixer
    nspr
    openal
    espeak-classic
    libGLU
    libogg
    libvorbis
  ];

  # upstream recommends this but I do not feel comfortable with it
  # https://github.com/OoliteProject/oolite/blob/d8dabec4bb2c830f502276e5c5823aef855ef66a/README.md?plain=1#L144
  env.NIX_CFLAGS_COMPILE = toString [
    #"-fobjc-exceptions" # compiler reports this flag is unused
    "-Wno-format-security"
    # silence some libGLU-related errors
    "-Wno-incompatible-function-pointer-types"
  ];

  env.LD_LIBRARY_PATH = lib.makeLibraryPath [ espeak-classic ];

  meta = with lib; {
    # build fails at linking stage:
    # /build/source/src/Core/OOCache.m:1058:(.text+0xcff): undefined reference to `__objc_ivar_offset_OOCache.cache.^{OOCacheImpl=^{OOCacheNode}^{OOCacheNode}^{OOCacheNode}I^A}'
    broken = true;
    description =
      "Free and open source game inspired by Elite";
    homepage = "https://www.oolite.space/";
    #mainProgram = "";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
