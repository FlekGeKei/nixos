{ pkgs ? import<nixpkgs> {} }:
let fhs = pkgs.buildFHSUserEnv {
  name = "gradle-env";
  targetPkgs = pkgs : (with pkgs;
  [
    gradle
    kotlin
    jdk8
    zlib
    ncurses
  ]);
};
in pkgs.stdenv.mkDerivation {
  name = "gradle-env-shell";
  nativeBuildInputs = [ fhs ];
  shellHook="exec gradle-env";
}
