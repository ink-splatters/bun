{
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    inherit (config) pre-commit craneLib commonArgs;
  in {
    devShells.default =
      craneLib.devShell.override {
        mkShell = pkgs.mkShell.override {
          inherit (config.llvm) stdenv;
        };
      } ({
          # TODO: building package is required for checks
          # inherit (config) checks;

          packages = pre-commit.settings.enabledPackages ++ commonArgs.nativeBuildInputs;

          shellHook = ''
            ${pre-commit.installationScript}
          '';
        }
        // (builtins.removeAttrs commonArgs ["src" "stdenv" "nativeBuildInputs"]));
  };
}
