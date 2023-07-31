{
  stdenv,
  qmake,
  qtbase,
  qtdeclarative,
  wrapQtAppsHook,
  qtwayland
}:
stdenv.mkDerivation rec {
  name = "vmmanager";

  depsBuildBuild = [
    qmake
    qtdeclarative
    wrapQtAppsHook
  ];

  depsBuildHost = [
    qtbase
    qtdeclarative
    qtwayland
  ];

  src = ./.;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin; mv -t $out/bin vmmanager

    runHook postInstall
  '';
}
