{ lib
, fetchFromGitHub
, gnustep
, SDL
, SDL_image
, SDL_mixer
, nspr
, openal
, espeak
, libGLU
, libogg
, libvorbis
, pkg-config
}:

gnustep.gsmakeDerivation rec {
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

  buildInputs = [
    gnustep.base
    SDL
    SDL_image
    SDL_mixer
    nspr
    openal
    espeak
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

  meta = with lib; {
    # build fails at linking stage
    # linker cannot find espeak
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
