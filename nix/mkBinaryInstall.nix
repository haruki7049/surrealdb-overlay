{
  lib,
  fetchurl,
  stdenv,
  rpath ? lib.makeLibraryPath [ gcc-unwrapped ],
  gcc-unwrapped,
}:

{
  pname ? "surrealdb",
  version,
  srcs,
}:

let
  src =
    srcs.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in

stdenv.mkDerivation {
  inherit pname version src;

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
    description = "A scalable, distributed, collaborative, document-graph database, for the realtime web";
    homepage = "https://surrealdb.com/";
    mainProgram = "surreal";
    license = licenses.bsl11;
  };
}
