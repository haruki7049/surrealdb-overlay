self: super: {
  surrealdb = {
    "1.4.2" = let
      rpath = super.lib.makeLibraryPath [
        super.pkgs.gcc-unwrapped
      ];
    in
    super.stdenv.mkDerivation rec {
      pname = "surrealdb";
      version = "1.4.2";

      src = super.fetchurl {
        url = "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-amd64.tgz";
        hash = "sha256-JaHfiAZFgKP5RS0GCQBakYKHPnIqOtds1J65yTznGoI=";
      };

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp surreal $out/bin/surreal

        runHook postInstall
      '';

      postFixup = ''
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$out/bin/surreal" || true
        patchelf --set-rpath ${rpath} "$out/bin/surreal" || true
      '';
    };
  };
}
