self: super: {
  surrealdb = {
    "1.4.2" = super.stdenv.mkDerivation rec {
      pname = "surrealdb";
      version = "1.4.2";

      src = super.fetchurl {
        url = "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-amd64.tgz";
        hash = "";
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp surreal $out/bin/surreal

        runHook postInstall
      '';
    };
  };
}
