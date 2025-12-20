{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages.zlib = let
      inherit (config) flags;
    in
      (pkgs.zlib-ng.override {
        inherit (config.llvm) stdenv;
        withZlibCompat = true;
      }).overrideAttrs (oa: {
        nativeBuildInputs = with config.llvm;
          [
            clang
            bintools
            pkgs.ninja
          ]
          ++ oa.nativeBuildInputs;

        preConfigure = ''
          cmakeFlagsArray+=(
            "-DCMAKE_C_FLAGS=${builtins.toString flags.optimized-lto}"
            "-DCMAKE_CXX_FLAGS=${builtins.toString flags.optimized-lto}"
            "-DCMAKE_EXE_LINKER_FLAGS=${builtins.toString flags.ldflags}"
          )
        '';
        NIX_ENFORCE_NO_NATIVE = 0;

        enableParallelBuilding = true;

        # hardeningDisable = ["all"];
      });
  };
}
