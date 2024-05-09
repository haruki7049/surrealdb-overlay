self: super: {
  surrealdb = let
    pname = "surrealdb";
    inherit (super.stdenv.hostPlatform) system;
    rpath = super.lib.makeLibraryPath [ super.pkgs.gcc-unwrapped ];

    releases = builtins.fromJSON (builtins.readFile ./sources.json);
    assets = builtins.concatMap (release: release.assets) releases;
    downloadURLs = builtins.map (asset: asset.browser_download_url) assets;

    x86_64-linuxURLs =
      builtins.filter (link: super.lib.strings.hasInfix "linux-amd" link)
      downloadURLs;
    aarch64-linuxURLs =
      builtins.filter (link: super.lib.strings.hasInfix "linux-arm64" link)
      downloadURLs;
    x86_64-linuxUrlFetcher = version:
      builtins.head
      (builtins.filter (url: super.lib.strings.hasInfix version url)
        x86_64-linuxURLs);
    aarch64-linuxUrlFetcher = version:
      builtins.head
      (builtins.filter (url: super.lib.strings.hasInfix version url)
        aarch64-linuxURLs);

    mkBinaryInstall = { version, x86_64-linuxHash, aarch64-linuxHash, }:
      super.stdenv.mkDerivation rec {
        inherit pname version;

        src = {
          x86_64-linux = super.fetchurl {
            url = x86_64-linuxUrlFetcher version;
            hash = x86_64-linuxHash;
          };
          aarch64-linux = super.fetchurl {
            url = aarch64-linuxUrlFetcher version;
            hash = aarch64-linuxHash;
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
    "1.4.2" = surrealdb-template "1.4.2"
      "sha256-JaHfiAZFgKP5RS0GCQBakYKHPnIqOtds1J65yTznGoI="
      "sha256-hlMtgEaonW41TTd2Ilrx3oXY5mdnZjfccPmg4x/6qnU=";
  };
}
