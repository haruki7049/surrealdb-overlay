self: super: {
  surrealdb = {
    "1.4.2" = let
      inherit (super.stdenv.hostPlatform) system;
      rpath = super.lib.makeLibraryPath [ super.pkgs.gcc-unwrapped ];
    in super.stdenv.mkDerivation rec {
      pname = "surrealdb";
      version = "1.4.2";

      src = {
        x86_64-linux = super.fetchurl {
          url =
            "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-amd64.tgz";
          hash = "sha256-JaHfiAZFgKP5RS0GCQBakYKHPnIqOtds1J65yTznGoI=";
        };
        aarch64-linux = super.fetchurl {
          url =
            "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-arm64.tgz";
          hash = "sha256-hlMtgEaonW41TTd2Ilrx3oXY5mdnZjfccPmg4x/6qnU=";
        };
      }.${system};

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp surreal $out/bin/surrealdb

        runHook postInstall
      '';

      postFixup = ''
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$out/bin/surrealdb" || true
        patchelf --set-rpath ${rpath} "$out/bin/surrealdb" || true
      '';

      meta = with super.lib; {
        description =
          "A scalable, distributed, collaborative, document-graph database, for the realtime web";
        homepage = "https://surrealdb.com/";
        mainProgram = "surrealdb";
        license = licenses.bsl11;
      };
    };
  };
}
