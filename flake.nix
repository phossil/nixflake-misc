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
        qvwm = callPackage ./packages/qvwm { };
        #wapanel = callPackage ./packages/wapanel { }; # TODO: remove later
        unifraktur-cook = callPackage ./packages/unifraktur-cook { };
        unifraktur-maguntia = callPackage ./packages/unifraktur-maguntia { };
        brass_mono = callPackage ./packages/brass-mono { };
        #oolite = callPackage ./packages/oolite { };
        #lem = callPackage ./packages/lem { };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
