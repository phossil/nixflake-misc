{ pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  loudgain = callPackage ./loudgain { };
  # broken
  etoile = callPackage ./etoile {
    llvm = callPackage ./etoile/llvm.nix {
      stdenv = pkgs.gcc49Stdenv;
    };
  };
  clasp-common-lisp = callPackage ./clasp {
    llvmPackages = pkgs.llvmPackages_15;
  };
  qvwm = callPackage ./qvwm { };
  egmde = callPackage ./egmde { };
  sfwbar = callPackage ./sfwbar { };
  # broken
  lainwm = callPackage ./lainwm { };
  # broken
  musicnya-desktop = callPackage ./musicnya-desktop { };
  # broken bc im stupid
  lem = callPackage ./lem { };
  wapanel = callPackage ./wapanel { };
  # broken
  cocotron = callPackage ./cocotron { };
  # broken
  cpdup = callPackage ./cpdup { };
  # broken
  radium = callPackage ./radium { };

  /* depends on forked flake
  # all broken bc macos projects with gnustep-xcode
  nimble-commander = callPackage ./nimble-commander {
    gnustep-xcode = self.xcode;
  };
  skim-app = callPackage ./skim-app {
    gnustep-xcode = self.xcode;
  };
  hex_fiend = callPackage ./hexfiend {
    gnustep-xcode = self.xcode;
  };
  # broken
  adium = callPackage ./adium {
    gnustep-xcode = self.xcode;
  };
  filer = callPackage ./filer {
    gnustep-xcode = self.xcode;
  };
  */
})
