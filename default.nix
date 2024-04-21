self: super: {
  surrealdb = {
    "1.4.2" = super.stdenv.mkDerivation rec {
      pname = "surrealdb";
      version = "1.4.2";

      src = super.fetchurl {
        url = "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-amd64.tgz";
        hash = "sha256-10hswwyckfcysindffiaf8z8g0lib800j1id8pws70250s4dz895";
      };

      nativeBuildInputs = [ super.pkg-config super.rustPlatform.bindgenHook ];

      buildInputs = [ super.openssl ] ++ super.lib.optionals stdenv.isDarwin
        [ super.darwin.app_sdk.frameworks.SystemConfiguration ];

      PROTOC = "${super.protobuf}/bin/protoc";
      PROTOC_INCLUDE = "${super.protobuf}/include";

      ROCKSDB_INCLUDE_DIR = "${super.rocksdb}/include";
      ROCKSDB_LIB_DIR = "${super.rocksdb}/lib";

      __darwinAllowLocalNetworking = true;
    };
  };
}
