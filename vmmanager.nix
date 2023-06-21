{
  autoPatchelfHook,
  qt5,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "vmmanager";

  nativeBuildInputs = [autoPatchelfHook qt5.wrapQtAppsHook qt5.qtdeclarative];

  buildInputs = [qt5.qmake qt5.qtbase qt5.qtdeclarative];

  src = ./.;

  buildPhase = "qmake; make";
  installPhase = "mkdir -p $out/bin; mv -t $out/bin vmmanager";
}
