{ pkgs ? import <nixpkgs> { inherit overlays; }
, overlays ? [ (import ../default.nix) ], mkShell ? pkgs.mkShell }:

mkShell { packages = [ pkgs.surrealdb."1.4.2" ]; }
