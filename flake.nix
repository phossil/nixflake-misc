{
  description = "flake with random packages i might submit into nixpkgs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      packages.${system} = with pkgs; rec {
        qvwm = callPackage ./packages/qvwm { };
        unifraktur-cook = callPackage ./packages/unifraktur-cook { };
        unifraktur-maguntia = callPackage ./packages/unifraktur-maguntia { };
        brass_mono = callPackage ./packages/brass-mono { };
        cairo-dock-core = callPackage ./packages/cairo-dock-core { };
        cairo-dock-plug-ins = callPackage ./packages/cairo-dock-plug-ins { inherit cairo-dock-core; };
        concord = callPackage ./packages/concord { };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
