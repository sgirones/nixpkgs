{ lib, stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "revanced-cli";
  version = "4.4.1";

  src = fetchurl {
    url = "https://github.com/revanced/revanced-cli/releases/download/v${version}/revanced-cli-${version}-all.jar";
    hash = "sha256-8uhKbEA3H8GY4ydefkLXAqCZdDIZANs3gZQGYyCUdOM=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ jre ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$prefix/bin"

    makeWrapper ${jre}/bin/java $out/bin/revanced-cli \
      --add-flags "-jar $src" \
      --prefix PATH : "$PATH"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Command line application as an alternative to the ReVanced Manager";
    homepage = "https://github.com/revanced/revanced-cli";
    license = licenses.gpl3Only;
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    maintainers = with maintainers; [ jopejoe1 ];
    mainProgram = "revanced-cli";
  };
}
