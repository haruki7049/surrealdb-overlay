self: super:
let
  lib = super.lib;
  fetchurl = super.fetchurl;
  rpath = super.lib.makeLibraryPath [ super.pkgs.gcc-unwrapped ];
  mkBinaryInstall = { pname ? "surrealdb", version, url, sha256 }:
    super.stdenv.mkDerivation rec {
      inherit pname version;

      src = fetchurl {
        inherit url sha256;
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

      meta = with lib; {
        description =
          "A scalable, distributed, collaborative, document-graph database, for the realtime web";
        homepage = "https://surrealdb.com/";
        mainProgram = "surreal";
        license = licenses.bsl11;
      };
    };
in {
  surrealdb = {
    "1.4.2" = mkBinaryInstall {
      version = "1.4.2";
      url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-arm64.tgz";
      sha256 = "";
    };
  };
}
