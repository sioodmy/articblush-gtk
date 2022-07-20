{
  description = "Articblush gtk theme";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          articblush-gtk = pkgs.stdenvNoCC.mkDerivation {
            pname = "articblush-gtk";
            version = "0.2.0";
            src = nixpkgs.lib.cleanSource ./.;
            nativeBuildInputs = [ pkgs.nodePackages.sass pkgs.nodejs ];
            installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
          };
        };
        defaultPackage = packages.articblush-gtk;
      });
}
