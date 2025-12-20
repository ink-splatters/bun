{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    options = {
      buildInputs = with pkgs;
        lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default =
            [
              openssl
              config.packages.zlib
            ]
            ++ lib.optionals stdenv.isDarwin [
              apple-sdk_15
            ]
            # Chromium/Puppeteer deps
            # {{{
            # TODO: make optional (they are for browser tests)
            ++ lib.optionals stdenv.isLinux (
              (with xorg; [
                libX11
                libxcb
                libXcomposite
                libXcursor
                libXdamage
                libXext
                libXfixes
                libXi
                libXrandr
                libXrender
                libXScrnSaver
                libXtst
                libxkbcommon
              ])
              ++ [
                mesa
                nspr
                nss
                cups.lib
                dbus.lib
                expat
                fontconfig
                freetype
                glib
                gtk3
                pango
                cairo
                alsa-lib
                at-spi2-atk
                at-spi2-core
                libgbm
                atk
                libdrm
                xorg.libxshmfence
                gdk-pixbuf
                liberation_ttf
              ]
            );
          # }}}
        };

      nativeBuildInputs = with pkgs;
        lib.mkOption {
          type = lib.types.listOf lib.types.package;

          default = with config.llvm;
            [
              clang
              bintools
              llvm
            ]
            ++ [
              cmake
              ninja
              pkg-config

              zig

              sccache

              bun # Bun itself (for running build scripts via `bun bd`)
              nodejs_24

              python3

              gitMinimal
              curl
              wget
              unzip
              xz
            ]
            ++ lib.optionals stdenv.isLinux [
              gdb
            ];
        };
    };
  };
}
