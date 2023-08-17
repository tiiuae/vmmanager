{
  stdenv,
  makeWrapper,
  qmake,
  qtbase,
  qtdeclarative,
  qtquickcontrols2,
  qtgraphicaleffects,
  vmd-client,
  wrapQtAppsHook,
  qtwayland
}:
stdenv.mkDerivation rec {
  name = "vmmanager";

  depsBuildBuild = [
    makeWrapper
    qmake
    qtdeclarative
    qtquickcontrols2
    qtgraphicaleffects
    wrapQtAppsHook
  ];

  depsBuildHost = [
    qtbase
    qtdeclarative
    qtquickcontrols2
    qtgraphicaleffects
    qtwayland
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
