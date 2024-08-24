with import <nixpkgs> { };
let
  llvmPackages = llvmPackages_18;
  clang = clang_18;
  lld = lld_18;
in

(
  {
    clang,
    lld,
    llvmPackages,
    ...
  }:
  let
    inherit (llvmPackages) stdenv libcxx;
  in
  mkShell.override { inherit stdenv; } {
    nativeBuildInputs = [
      libcxx
      clang
      lld
      gnumake
    ];

    shellHook = ''
      export CXXFLAGS="-isystem ${libcxx.dev}/include/c++/v1 -Wall -O3 -mcpu=apple-m1 -funroll-loops -ffast-math -std=c++20 -stdlib=libc++ -flto=thin"
      export LDFLAGS="-fuse-ld=lld"
      export CC=clang++
    '';

  }
)

  { inherit clang lld llvmPackages; }
