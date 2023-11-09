{ pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  loudgain = callPackage ./loudgain { };
  qvwm = callPackage ./qvwm { };
  egmde = callPackage ./egmde { };
  sfwbar = callPackage ./sfwbar { };
  wapanel = callPackage ./wapanel { };
})
