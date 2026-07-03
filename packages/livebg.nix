{
  egl-wayland,
  fetchFromCodeberg,
  ffmpeg,
  libGL,
  meson,
  ninja,
  pkg-config,
  stdenv,
  wayland,
  wayland-protocols,
  wayland-scanner,
}:
let
  version = "1.0.2";
in
stdenv.mkDerivation {
  inherit version;
  pname = "livebg";
  src = fetchFromCodeberg {
    repo = "livebg";
    owner = "mbitsnbites";
    hash = "sha256-SbWUV7bDV/1aDUDFBmo60GhJF2YT6QWsWZrD5bx/9FA=";
    rev = version;
  };

  nativeBuildInputs = [
    meson
    ninja
    wayland-protocols
  ];

  buildInputs = [
    egl-wayland
    ffmpeg
    libGL
    pkg-config
    wayland
    wayland-scanner
  ];
}
