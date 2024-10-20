self: super:
let
  mkBinaryInstall = super.callPackage ./nix/mkBinaryInstall.nix { };
in
{
  surrealdb = {
    "1.4.2" = mkBinaryInstall {
      version = "1.4.2";
      srcs = {
        x86_64-linux = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-amd64.tgz";
          sha256 = "10hswwyckfcysindffiaf8z8g0lib800j1id8pws70250s4dz895";
        };
        aarch64-linux = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-arm64.tgz";
          sha256 = "0xdaz8gy787rf3f3frk7czkdi1fyy5d24xip9lsnx7d88s02slw6";
        };
        x86_64-darwin = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.darwin-amd64.tgz";
          sha256 = "1vbs8fcajvsvf07wjf3m926liq5wjmkq2zcrcc489907xbiqms02";
        };
        aarch64-darwin = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.darwin-arm64.tgz";
          sha256 = "05jib510hg64a2v08z963v3xbcx1k1fdv1m82vr06yhzrdls3fbn";
        };
      };
    };
  };
}
