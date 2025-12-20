{lib, ...}: let
  listOfStr = lib.types.listOf lib.types.str;
  mkFlags = default:
    lib.mkOption {
      inherit default;
      type = listOfStr;
    };

  flagsSubmodule = {config, ...}: {
    options = {
      basic = mkFlags ["-pipe" "-Werror"];
      o3 = mkFlags ["-O3"];
      native = mkFlags ["-mcpu=native"];
      lto = mkFlags ["-flto=thin"];
      ldflags = mkFlags ["-fuse-ld=lld"];

      # Computed from other options - defaults reference config
      optimized = lib.mkOption {
        type = listOfStr;
        default = config.basic ++ config.o3 ++ config.native;
      };
      optimized-lto = lib.mkOption {
        type = listOfStr;
        default = config.optimized ++ config.lto;
      };
    };
  };
in {
  perSystem = {
    options.flags = lib.mkOption {
      type = lib.types.submodule flagsSubmodule;
      default = {};
    };
  };
}
