{ lib, fetchFromGithub, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "musicnya-desktop";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "scarryaa";
    repo = pname;
    rev = "af9ad7c68b598b10f7f3e0c5578f2364996217bc";
    sha256 = "cHcKmGGhRYwOjBl0cXphoT8btmQZsIm63hO2RTt7dLc=";
    fetchSubmodules = true;
  };

  npmDepsHash = "sha256-6SjClF/5MD49C60qcE81iHLwmAlLm1S7z/+GAQqUo7Y=";

  # ah ha ha
  makeCacheWritable = true;
  npmFlags = [ "--legacy-peer-deps" "--force" ];

  meta = with lib; {
    # WIP
    broken = true;
    description = "meow meow meow meow meow meow meow";
    homepage = "https://github.com/scarryaa/musicnya-desktop";
    #license = licenses.gpl3Only;
    maintainers = with maintainers; [ phossil ];
  };
}
