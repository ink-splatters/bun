{lib, ...}: {
  perSystem = {config, ...}: {
    options = {
      rustFlags = lib.mkOption {
        default = map (x: "-C ${x}") [
          "linker=${config.llvm.clang}/bin/cc"
          "link-args=-fuse-ld=lld"
          "embed-bitcode=yes"
          "lto=thin"
        ];
      };
      rustZFlags = lib.mkOption {
        default = ["-Z dylib-lto"];
      };
    };
  };
}
