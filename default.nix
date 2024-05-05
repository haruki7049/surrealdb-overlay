self: super: {
  surrealdb = {
    "1.4.2" = super.stdenv.mkDerivation rec {
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

      preFixup = let
        libPath = with super; super.lib.makeLibraryPath [
          ell
          glibc
        ];
      in ''
        patchelf \
          --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "${libPath}" \
          $out/bin/surreal
      '';
    };
  };
}
