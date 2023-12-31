{ pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  loudgain = callPackage ./loudgain { };
  qvwm = callPackage ./qvwm { };
  sfwbar = callPackage ./sfwbar { };
  wapanel = callPackage ./wapanel { };
  unifraktur-cook = callPackage ./unifraktur-cook { };
  unifraktur-maguntia = callPackage ./unifraktur-maguntia { };
})
