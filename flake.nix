{
  description = "flake for testing miscellaneous derivations";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      # these are yet to be added to nixpkgs
      packages.${system} = with pkgs; {
        loudgain = callPackage ./pkgs/loudgain { };
        # broken
        etoile = callPackage ./pkgs/etoile {
          llvm = callPackage ./pkgs/etoile/llvm.nix {
            stdenv = gcc49Stdenv;
          };
        };
        clasp-common-lisp = callPackage ./pkgs/clasp {
          llvmPackages = llvmPackages_15;
        };
        qvwm = callPackage ./pkgs/qvwm { };
        egmde = callPackage ./pkgs/egmde { };
        sfwbar = callPackage ./pkgs/sfwbar { };
        # broken
        lainwm = callPackage ./pkgs/lainwm { };
        # broken
        musicnya-desktop = callPackage ./pkgs/musicnya-desktop { };
        # broken bc im stupid
        lem = callPackage ./pkgs/lem { };
        wapanel = callPackage ./pkgs/wapanel { };
        # broken
        nimble-commander = callPackage ./pkgs/nimble-commander {
          gnustep-xcode = self.packages.${system}.xcode;
        };
        xcode = callPackage ./pkgs/gnustep/xcode { };
        terminal = callPackage ./pkgs/gnustep/terminal { };
        price = callPackage ./pkgs/gnustep/price { };
        # broken
        gnustep-gap = callPackage ./pkgs/gnustep/gap { };
        step_sync = callPackage ./pkgs/gnustep/stepsync { };
        plugins-themes-Gtk = callPackage ./pkgs/gnustep/plugins-themes-Gtk { };
        # broken
        skim-app = callPackage ./pkgs/skim-app {
          gnustep-xcode = self.packages.${system}.xcode;
        };
        # broken
        cenon = callPackage ./pkgs/gnustep/cenon { };
        help_viewer = callPackage ./pkgs/gnustep/helpviewer { };
        ftp = callPackage ./pkgs/gnustep/ftp { };
        graphos = callPackage ./pkgs/gnustep/graphos { };
        # broken
        code_editor = callPackage ./pkgs/gnustep/codeeditor { };
        # broken
        steptalk = callPackage ./pkgs/gnustep/steptalk { };
        text_edit = callPackage ./pkgs/gnustep/textedit { };
        # broken
        hex_fiend = callPackage ./pkgs/hexfiend {
          gnustep-xcode = self.packages.${system}.xcode;
        };
        # broken
        adium = callPackage ./pkgs/adium {
          gnustep-xcode = self.packages.${system}.xcode;
        };
        # broken
        corebase = callPackage ./pkgs/gnustep/corebase { };
        # broken
        dbuskit = callPackage ./pkgs/gnustep/dbuskit { };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
