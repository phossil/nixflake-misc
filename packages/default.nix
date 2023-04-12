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
  nimble-commander = callPackage ./nimble-commander {
    gnustep-xcode = self.xcode;
  };
  xcode = callPackage ./gnustep/libs/xcode { };
  terminal = callPackage ./gnustep/terminal { };
  price = callPackage ./gnustep/price { };
  step_sync = callPackage ./gnustep/stepsync { };
  themes-gtk = callPackage ./gnustep/plugins/themes-gtk { };
  # broken
  skim-app = callPackage ./skim-app {
    gnustep-xcode = self.xcode;
  };
  # broken
  cenon = callPackage ./gnustep/cenon { };
  help_viewer = callPackage ./gnustep/helpviewer { };
  ftp = callPackage ./gnustep/ftp { };
  graphos = callPackage ./gnustep/graphos { };
  # broken
  code_editor = callPackage ./gnustep/codeeditor { };
  # broken
  steptalk = callPackage ./gnustep/steptalk { };
  text_edit = callPackage ./gnustep/textedit { };
  # broken
  hex_fiend = callPackage ./hexfiend {
    gnustep-xcode = self.xcode;
  };
  # broken
  adium = callPackage ./adium {
    gnustep-xcode = self.xcode;
  };
  # broken
  corebase = callPackage ./gnustep/libs/corebase { };
  dbuskit = callPackage ./gnustep/libs/dbuskit { };
  # broken
  opal = callPackage ./gnustep/libs/opal { };
  simplewebkit = callPackage ./gnustep/libs/simplewebkit { };
  vespucci = callPackage ./gnustep/vespucci {
    simplewebkit = self.simplewebkit;
  };
  # broken
  filer = callPackage ./filer {
    gnustep-xcode = self.xcode;
  };
  # broken
  cocotron = callPackage ./cocotron { };
  # broken
  themes-win_ux_theme = callPackage ./gnustep/plugins/themes-winuxtheme { };
  cpdup = callPackage ./cpdup { };
})
