{lib, ...}: {
  imports = [
    ./flags.nix
    ./inputs.nix
    ./llvm.nix
    ./rust
    ./zlib-ng.nix
  ];

  perSystem = {config, ...}: let
    inherit (config) craneLib flags;

    mkCommonArgs = args @ {
      cflags ? flags.basic,
      ldflags ? flags.ldflags,
      rustFlags ? config.rustFlags,
      hardeningDisable ? [],
      ...
    }:
      {
        src = craneLib.cleanCargoSource config.src;
        stdenv = _: config.llvm.stdenv;
        strictDeps = true;
        enableParallelBuilding = true;

        CFLAGS = builtins.toString cflags;
        CXXFLAGS = builtins.toString cflags;
        LDFLAGS = builtins.toString ldflags;

        RUSTFLAGS = builtins.toString (rustFlags ++ config.rustZFlags);

        inherit (config) buildInputs nativeBuildInputs;
        inherit hardeningDisable;
      }
      // (builtins.removeAttrs args ["cflags" "ldflags" "rustFlags" "hardeningDisable"]);
  in {
    options = {
      commonArgs = lib.mkOption {
        type = lib.types.attrs;
        default = mkCommonArgs {};
      };

      commonArgsOptimized = lib.mkOption {
        type = lib.types.attrs;

        default = mkCommonArgs {
          rustFlags = config.rustFlags ++ ["target-cpu=native"];
          NIX_ENFORCE_NO_NATIVE = 0;

          cflags = flags.optimized-lto;

          # TODO: as needed
          # hardeningDisable = ["all"];
        };
      };
    };
  };
}
