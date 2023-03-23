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
      packages.${system} = {
        loudgain = pkgs.callPackage ./pkgs/loudgain { };
        # broken
        etoile = pkgs.callPackage ./pkgs/etoile {
          llvm = pkgs.callPackage ./pkgs/etoile/llvm.nix {
            stdenv = pkgs.gcc49Stdenv;
          };
        };
        clasp-common-lisp = with pkgs; callPackage ./pkgs/clasp {
          llvmPackages = llvmPackages_15;
        };
        qvwm = pkgs.callPackage ./pkgs/qvwm { };
        egmde = pkgs.callPackage ./pkgs/egmde { };
        sfwbar = pkgs.callPackage ./pkgs/sfwbar { };
        # broken
        lainwm = pkgs.callPackage ./pkgs/lainwm { };
        # broken
        musicnya-desktop = pkgs.callPackage ./pkgs/musicnya-desktop { };
        # broken bc im stupid
        lem = pkgs.callPackage ./pkgs/lem { };
        wapanel = pkgs.callPackage ./pkgs/wapanel { };
        # broken bc missing dep
        nimble-commander = pkgs.callPackage ./pkgs/nimble-commander { };
      };
    };
}
