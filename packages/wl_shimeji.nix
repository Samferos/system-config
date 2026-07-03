{
  fetchFromGitHub,
  libarchive,
  pkg-config,
  python3,
  stdenv,
  uthash,
  wayland,
  wayland-protocols,
  wayland-scanner,
  which,
}:
let
  version = "8ae15cf7e56325b08708e1b8d851baef679962d1";
in
stdenv.mkDerivation {
  inherit version;
  pname = "wl_shimeji";
  src = fetchFromGitHub {
    owner = "CluelessCatBurger";
    repo = "wl_shimeji";
    hash = "sha256-dNShG6SS1jiT0JpI817TSIS7v1JLHSY8T04vhGpD6xo=";
    rev = version;
    fetchSubmodules = true;
  };
  nativeBuildInputs = [
    libarchive
    pkg-config
    python3
    uthash
    wayland
    wayland-protocols
    wayland-scanner
    which
  ];
  preBuild = ''
    export DESTDIR=$out
  '';
}
