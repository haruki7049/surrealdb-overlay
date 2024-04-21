self: super: {
  surrealdb = {
    "1.4.2" = super.rustPlatform.buildRustPackage rec {
      pname = "surrealdb";
      version = "1.4.2";

      src = super.fetchFromGitHub {
        owner = pname;
        repo = pname;
        rev = "v${version}";
        hash = "";
      };

      cargoHash = "";

      nativeBuildInputs = [ super.pkg-config super.rustPlatform.bindgenHook ];

      buildInputs = [ super.openssl ] ++ lib.optionals stdenv.isDarwin
        [ super.darwin.app_sdk.frameworks.SystemConfiguration ];

      PROTOC = "${super.protobuf}/bin/protoc";
      PROTOC_INCLUDE = "${super.protobuf}/include";

      ROCKSDB_INCLUDE_DIR = "${super.rocksdb}/include";
      ROCKSDB_LIB_DIR = "${super.rocksdb}/lib";

      __darwinAllowLocalNetworking = true;
    };
  };
}
