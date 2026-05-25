{
  description = "Mona";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
      lib = pkgs.lib;

      runtimeLibs = with pkgs; [
        libepoxy fontconfig.lib
        gtk3 glib.out pango.out cairo gdk-pixbuf atk
        libselinux.out libsepol.out
        libthai libdatrie.out harfbuzz fribidi zlib
        libx11 libxcursor libxrandr libxi libxdmcp libxau libxcb
        libxkbcommon dbus systemd
      ];
    in
      pkgs.mkShell {
        packages = with pkgs; [
          pkg-config fvm clang cmake ninja
          # GTK stack — in packages so nixpkgs pkg-config wrapper auto-discovers .pc files
          gtk3 glib cairo pango gdk-pixbuf libepoxy fontconfig dbus
          at-spi2-core libsysprof-capture pcre2 libffi
          # Image libs (gdk-pixbuf/libtiff transitive)
          libtiff libdeflate lerc libjpeg libpng libwebp jbigkit xz zstd
          # System (gio/dbus chain)
          util-linux libselinux libsepol zlib systemd expat
          # Text rendering (pango chain)
          libthai libdatrie harfbuzz fribidi
          # X11
          libx11 libxcursor libxrandr libxi libxdmcp libxau libxcb libxkbcommon
        ];

        NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
        NIX_LD_LIBRARY_PATH = lib.makeLibraryPath ([pkgs.stdenv.cc.cc] ++ runtimeLibs);
        LD_LIBRARY_PATH = lib.makeLibraryPath runtimeLibs;

        LDFLAGS = "-Wl,--allow-shlib-undefined " + lib.concatMapStringsSep " " (p: "-L${p}/lib") (with pkgs; [
          libepoxy fontconfig.lib gtk3 glib.out pango.out cairo gdk-pixbuf
          libselinux.out libsepol.out libthai libdatrie.out harfbuzz fribidi
          libxdmcp libxau libxcb
        ]);
      };
  };
}
