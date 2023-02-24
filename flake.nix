{
  description = "flake for testing miscellaneous derivations";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs-19_03 = {
      url = "github:NixOS/nixpkgs/release-19.03";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-19_03 }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        loudgain = pkgs.callPackage ./pkgs/loudgain { };
        #etoile = pkgs.callPackage ./pkgs/etoile { };
        #clasp-common-lisp = pkgs.callPackage ./pkgs/clasp { };
        egmde = pkgs.callPackage ./pkgs/egmde { };
        sfwbar = pkgs.callPackage ./pkgs/sfwbar { };
      };
    };
}
