{
  perSystem =
    # {config,...}:
    # let
    #   inherit (config) craneLib commonArgs src cargoArtifacts;
    # in
    {
      checks = {
        # TODO: we don't run any checks because package is not being built by the flake yet

        # inherit (config.packages) bun;

        # bun-clippy = craneLib.cargoClippy (
        #   commonArgs
        #   // {
        #     inherit cargoArtifacts;
        #     cargoClippyExtraArgs = "--all-targets -- --deny warnings";
        #   }
        # );

        # bun-doc = craneLib.cargoDoc (
        #   commonArgs
        #   // {
        #     inherit cargoArtifacts;
        #   }
        # );

        # bun-fmt = craneLib.cargoFmt {
        #   inherit src;
        # };

        # bun-nextest = craneLib.cargoNextest (
        #   commonArgs
        #   // {
        #     inherit cargoArtifacts;
        #     partitions = 1;
        #     partitionType = "count";
        #   }
        # );
      };
    };
}
