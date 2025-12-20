# {lib, ...}:
{
  perSystem =
    # {config, ...}:
    #  let
    #   inherit (config) craneLib commonArgs commonArgsNativeOptimized;
    #   default = {pname = "bun";};
    # in
    {
      options = {
        # # TODO: make a nested (submodule) option oer artufact]
        # cargoDeps = lib.mkOption {
        #   type = lib.types.package;
        #   default = craneLib.buildDepsOnly (commonArgs
        #     // default
        #     // {
        #       # Include dev dependencies for clippy offline mode
        #       cargoCheckExtraArgs = "--all-targets --all-features";
        #     });
        # };
        # cargoDepsNativeOptimized = lib.mkOption {
        #   type = lib.types.package;
        #   default =
        #     craneLib.buildDepsOnly (commonArgsNativeOptimized
        #       // default);
        # };
      };
    };
}
