self: super:
let
  mkBinaryInstall-x86_64-linux = super.callPackage ./nix/mkBinaryInstall.x86_64-linux.nix { };
in
{
  surrealdb = {
    "1.4.2" = mkBinaryInstall-x86_64-linux {
      version = "1.4.2";
      url = "https://github.com/surrealdb/surrealdb/releases/download/v1.4.2/surreal-v1.4.2.linux-amd64.tgz";
      sha256 = "10hswwyckfcysindffiaf8z8g0lib800j1id8pws70250s4dz895";
    };
  };
}
