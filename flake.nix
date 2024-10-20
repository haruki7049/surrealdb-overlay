{
  description = "An overlay for Godot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      flake.overlays.surrealdb-overlay =
        self: super:
        let
          mkBinaryInstall = super.callPackage ./nix/mkBinaryInstall.nix { };
        in
        {
          surrealdb = {
            "1.4.2" = mkBinaryInstall {
              version = "1.4.2";
              url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-amd64.tgz";
              sha256 = "10hswwyckfcysindffiaf8z8g0lib800j1id8pws70250s4dz895";
            };
          };
        };

      perSystem =
        { pkgs, ... }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.actionlint.enable = true;
          };

          devShells.default = pkgs.mkShell {
            packages = [
              pkgs.nil
            ];
          };
        };
    };
}
