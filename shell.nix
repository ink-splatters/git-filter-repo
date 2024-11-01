with import <nixpkgs> { };
let
  inherit (llvmPackages_19) libcxxStdenv bintools lld;
  stdenv = libcxxStdenv;
in
mkShell.override { inherit stdenv; } {
  nativeBuildInputs = [
    lld
    gnumake
  ];

  shellHook = ''
    export CXXFLAGS="-Wall -O3 -mcpu=apple-m1 -funroll-loops -ffast-math -std=c++20 -flto"
    export LDFLAGS="-fuse-ld=lld"
    export CC=clang++
  '';

}
