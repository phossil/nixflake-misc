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

      # copied from nixpkgs 19.03
      # please be aware this relies on an end-of-life release of python
      # and building llvm fails at `Linking CXX shared library ../libLLVMSupport.so`      
      llvmPackages_37 = with lib; with pkgs; callPackage ./pkgs/llvm/3.7 ({
        # default gcc toolchain in nixos-unstable is too new
        #stdenv = overrideCC stdenv buildPackages.gcc6;
        inherit (stdenvAdapters) overrideCC;
        buildLlvmTools = buildPackages.llvmPackages_37.tools;
        targetLlvmLibraries = targetPackages.llvmPackages_37.libraries or llvmPackages_37.libraries;
      } // lib.optionalAttrs (stdenv.cc.isGNU && stdenv.hostPlatform.isi686) {
        stdenv = overrideCC stdenv buildPackages.gcc6;
      });
    in
    {
      packages.${system} = {
        loudgain = pkgs.callPackage ./pkgs/loudgain { };
        # broken
        etoile = pkgs.callPackage ./pkgs/etoile { 
          llvmPackages = llvmPackages_37;
        };
        # broken
        clasp-common-lisp = with pkgs; callPackage ./pkgs/clasp {
          llvmPackages = llvmPackages_15;
          stdenv = llvmPackages_15.stdenv;
        };
        qvwm = pkgs.callPackage ./pkgs/qvwm { };
        egmde = pkgs.callPackage ./pkgs/egmde { };
        sfwbar = pkgs.callPackage ./pkgs/sfwbar { };
        # broken
        lainwm = pkgs.callPackage ./pkgs/lainwm { };
      };
    };
}
