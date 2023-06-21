{
  stdenv,
  makeWrapper,
  qmake,
  qtbase,
  qtdeclarative,
  vmd-client,
  wrapQtAppsHook,
}:
stdenv.mkDerivation rec {
  name = "vmmanager";

  depsBuildBuild = [
    makeWrapper
    qmake
    qtdeclarative
    wrapQtAppsHook
  ];

  depsBuildHost = [
    qtbase
    qtdeclarative
    vmd-client
  ];

  # TODO: It is now possible to get path to vmd-client binary from
  #       "${vmd-client}/bin/vmd-client", and it could be passed to the actual
  #       program using command line with makeWrapper, example seen below.
  qtWrapperArgs = [
    "--add-flags"
    "--vmd-client-dir"
    "--add-flags"
    "${vmd-client}/bin"
  ];

  src = ./.;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv -t $out/bin vmmanager

    runHook postInstall
  '';
}
