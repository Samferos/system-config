{
  lib,
  stdenv,
  fetchzip,
  patchelf,
  unzip,
  jre,
  makeWrapper,
}:

stdenv.mkDerivation {
  pname = "kotlin-lsp";
  version = "0.253.10629";
  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/0.253.10629/kotlin-0.253.10629.zip";
    hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    makeWrapper
    patchelf
    unzip
  ];

  buildInputs = [
    jre
  ];

  dontBuild = true;
  doCheck = true;

  installPhase = ''
    mkdir -p $out/{bin,$pname}
    cp -a . $out/$pname
    chmod +x $out/$pname/kotlin-lsp.sh
    ln -s $out/$pname/kotlin-lsp.sh $out/bin/kotlin-lsp

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/kotlin-lsp \
      --prefix PATH : ${
        lib.makeBinPath [
          jre
        ]
      }
  '';
}
