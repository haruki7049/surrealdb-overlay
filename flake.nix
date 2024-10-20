{
  description = "An overlay for Godot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
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

      perSystem = { pkgs, ... }: {
        treefmt = {
          projectRootFile = "treefmt.nix";
          programs.nixfmt.enable = true;
          programs.yamlfmt.enable = true;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nil
          ];
        };
      };
    };
}
