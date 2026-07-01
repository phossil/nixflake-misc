{
  description = "flake with random packages i might submit into nixpkgs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      # these are yet to be added to nixpkgs
      packages.${system} = with pkgs; {
        qvwm = callPackage ./packages/qvwm { };
        unifraktur-cook = callPackage ./packages/unifraktur-cook { };
        unifraktur-maguntia = callPackage ./packages/unifraktur-maguntia { };
        brass_mono = callPackage ./packages/brass-mono { };
        concord = callPackage ./packages/concord { };
        tpde = callPackage ./packages/tpde { llvmPackages = llvmPackages_22; };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
