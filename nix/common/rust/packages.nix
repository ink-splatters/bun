{
  perSystem =
    # {config, ...}: let
    #   inherit (config) craneLib commonArgsNativeOptimized cargoDepsNativeOptimized;
    # in
    {
      # TODO
      packages = {
        # bun-rust-stuff = craneLib.buildPackage (commonArgsNativeOptimized
        #   // {
        #     inherit cargoDepsNativeOptimized;
        #   });
      };
    };
}
