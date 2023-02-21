{
  description = "flake for testing miscellaneous derivations";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }:
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
