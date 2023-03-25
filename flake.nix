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
          libs-xcode = self.packages.${system}.xcode;
        };
        xcode = callPackage ./pkgs/gnustep/xcode { };
        # broken
        Terminal = callPackage ./pkgs/gnustep/Terminal { };
        PRICE = callPackage ./pkgs/gnustep/PRICE { };
        # broken
        gnustep-gap = callPackage ./pkgs/gnustep/gap { };
        StepSync = callPackage ./pkgs/gnustep/StepSync { };
        plugins-themes-Gtk = callPackage ./pkgs/gnustep/plugins-themes-Gtk { };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
