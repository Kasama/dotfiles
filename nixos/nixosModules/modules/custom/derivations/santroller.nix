{ lib, appimageTools, fetchurl }:

let
  version = "10.4.63";
  pname = "santroller-configurator";

  src = fetchurl {
    url =
      "https://github.com/santroller/santroller/releases/download/v${version}/SantrollerConfigurator.AppImage";
    hash =
      "sha256:0d479d86bee019539ac330570ee382cf38edd2000b7167c46934b8750586bef1";
  };

  appimageContents = appimageTools.extractType1 { inherit name src; };
in appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = {
    description = "Firmware for using various microcontrollers as controllers.";
    homepage = "https://github.com/santroller/santroller";
    downloadPage = "https://github.com/santroller/santroller/releases";
    license = lib.licenses.gpl3;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ sanjay900 ];
    platforms = [ "x86_64-linux" ];
  };
}
