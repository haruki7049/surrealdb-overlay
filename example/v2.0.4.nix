{
  pkgs ? import <nixpkgs> { inherit overlays; },
  overlays ? [ (import ../default.nix) ],
  mkShell ? pkgs.mkShell,
}:

mkShell { packages = [ pkgs.surrealdb."2.0.4" ]; }
