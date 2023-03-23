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
        # broken bc missing dep
        nimble-commander = callPackage ./pkgs/nimble-commander { };
      };
    };
}
