{lib, ...}: {
  perSystem = {pkgs, ...}: {
    options = {
      llvm = lib.mkOption {
        type = lib.types.attrs;
        default = pkgs.llvmPackages_latest;
      };
    };
  };
}
