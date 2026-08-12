{
  fetchurl,
  jre,
  lib,
  libx11,
  libxkbcommon,
  libxt,
  makeWrapper,
  stdenv,
}:

stdenv.mkDerivation rec {
  pname = "ninjabrain-bot";
  version = "1.5.2";
  src = fetchurl {
    url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/${version}/Ninjabrain-Bot-${version}.jar";
    hash = "sha256-mAmfYyGpDUrOwTQA6G0F96+NYOVjnC84Qn6WjccUUP8=";
  };

  buildInputs = [
    jre
    libxkbcommon
    makeWrapper
  ];

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/{bin,share/java}
    cp $src $out/share/java/ninjabrain-bot.jar
    makeWrapper ${jre}/bin/java $out/bin/ninjabrain-bot \
      --add-flags "-Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -jar $out/share/java/ninjabrain-bot.jar" \
      --prefix LD_LIBRARY_PATH : ${libx11}/lib \
      --prefix LD_LIBRARY_PATH : ${libxkbcommon}/lib \
      --prefix LD_LIBRARY_PATH : ${libxt}/lib
    runHook postInstall
  '';
}
