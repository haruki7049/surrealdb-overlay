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

    "2.0.4" = mkBinaryInstall {
      version = "2.0.4";
      srcs = {
        x86_64-linux = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v2.0.4/surreal-v2.0.4.linux-amd64.tgz";
          sha256 = "0z23sk1qqiy65f5ds4z08ag9igajx8h1wf50sd476v7iapqg9zp6";
        };
        aarch64-linux = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v2.0.4/surreal-v2.0.4.linux-arm64.tgz";
          sha256 = "1y6pysqk32b6c69yc57lpb0qvsd6zw41sm3vlca1gnw7l8qcvv2h";
        };
        x86_64-darwin = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v2.0.4/surreal-v2.0.4.darwin-amd64.tgz";
          sha256 = "1bwa2lw1jvam37sxk5aqn3g31rmp4wmfzympy21c564mwwqig91h";
        };
        aarch64-darwin = super.fetchurl {
          url = "https://github.com/surrealdb/surrealdb/releases/download/v2.0.4/surreal-v2.0.4.darwin-arm64.tgz";
          sha256 = "1f9cw8dq7nka6873l59569yyzvrxk018wnskmjg1n9i54dsms1z1";
        };
      };
    };
  };
}
