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
      lib = nixpkgs.lib;
    in
    {
      packages.${system} = {
        loudgain = pkgs.callPackage ./pkgs/loudgain { };
        #etoile = pkgs.callPackage ./pkgs/etoile { };
        #clasp-common-lisp = pkgs.callPackage ./pkgs/clasp { };
        egmde = pkgs.callPackage ./pkgs/egmde { };
        sfwbar = pkgs.callPackage ./pkgs/sfwbar { };
        llvmPackages_37 = with lib; with pkgs; callPackage ./pkgs/llvm/3.7 ({
          inherit (stdenvAdapters) overrideCC;
          buildLlvmTools = buildPackages.llvmPackages_37.tools;
          targetLlvmLibraries = targetPackages.llvmPackages_37.libraries;
        } // stdenv.lib.optionalAttrs (stdenv.cc.isGNU && stdenv.hostPlatform.isi686) {
          stdenv = overrideCC stdenv buildPackages.gcc6;
        });
      };
    };
}
