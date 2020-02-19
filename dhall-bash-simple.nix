{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-bash-1.0.28-x86_64-macos.tar.bz2";
    sha256 = "1flzfjb9qxphpgzpp9acpgxdylkn97zbrw6f3lbz6rnb2k7sc8b5";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-bash-1.0.28-x86_64-linux.tar.bz2";
    sha256 = "0v377zbna1m7mphgzmibbs35k3bshx22iwvnyciwryl9x2hglbsg";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
