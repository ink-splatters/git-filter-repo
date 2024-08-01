with import <nixpkgs> { };
let
  inherit (llvmPackages_18) stdenv libcxx;
in
mkShell.override { inherit stdenv; } {
  nativeBuildInputs = [
    libcxx
    clang_18
    lld_18
    gnumake
  ];

  shellHook = ''
    export CXXFLAGS="-isystem ${libcxx.dev}/include/c++/v1 -Wall -O3 -mcpu=apple-m1 -funroll-loops -ffast-math -std=c++20 -stdlib=libc++ -flto=thin"
    export LDFLAGS="-fuse-ld=lld"
    export CC=clang++
  '';

}
