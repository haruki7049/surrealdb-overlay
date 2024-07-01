self: super:
let
  inherit (super.stdenv.hostPlatform) system;
  rpath = super.lib.makeLibraryPath [ super.pkgs.gcc-unwrapped ];
  mkBinaryInstall = { pname ? "surrealdb", version, url, sha256 }:
    super.stdenv.mkDerivation rec {
      inherit pname version;

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
        cp surreal $out/bin/surreal

        runHook postInstall
      '';

      postFixup = ''
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$out/bin/surreal" || true
        patchelf --set-rpath ${rpath} "$out/bin/surreal" || true
      '';

      meta = with super.lib; {
        description =
          "A scalable, distributed, collaborative, document-graph database, for the realtime web";
        homepage = "https://surrealdb.com/";
        mainProgram = "surreal";
        license = licenses.bsl11;
      };
    };
in {
  surrealdb = {
    "1.4.2" = let
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
        cp surreal $out/bin/surreal

        runHook postInstall
      '';

      postFixup = ''
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$out/bin/surreal" || true
        patchelf --set-rpath ${rpath} "$out/bin/surreal" || true
      '';

      meta = with super.lib; {
        description =
          "A scalable, distributed, collaborative, document-graph database, for the realtime web";
        homepage = "https://surrealdb.com/";
        mainProgram = "surreal";
        license = licenses.bsl11;
      };
    };
  };
}
