/*
  install with
  nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
*/
{ pythonPackages  }:

pythonPackages.buildPythonPackage rec {
  name = "nixops-modular-1.2";
  namePrefix = "";

  src = ./.;

  pythonPath =
    [ pythonPackages.prettytable
      pythonPackages.boto
      pythonPackages.sqlite3
      pythonPackages.hetzner
    ];

  doCheck = false;

  postInstall =
    ''
      mkdir -p $out/share/nix/nixops
      cp -av nix/* $out/share/nix/nixops

      mv $out/bin/nixops $out/bin/nixops-modular
    '';

  meta = {
    homepage = https://github.com/zalora/nixops;
    description = "Modular NixOS cloud provisioning and deployment tool";
  };
}
