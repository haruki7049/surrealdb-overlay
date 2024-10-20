self: super:
let
  mkBinaryInstall = super.callPackage ./nix/mkBinaryInstall.nix { };
in
{
  surrealdb = {
    "1.4.2" = mkBinaryInstall {
      version = "1.4.2";
      url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-amd64.tgz";
      sha256 = "10hswwyckfcysindffiaf8z8g0lib800j1id8pws70250s4dz895";
    };
  };
}
