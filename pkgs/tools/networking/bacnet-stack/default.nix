{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "bacnet-stack";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "bacnet-stack";
    repo = "bacnet-stack";
    rev = "bacnet-stack-${version}";
    sha256 = "sha256-fFQIyZYHHNyszUO8jySIB9Y/Amzj/TTdxaex76ovBmw=";
  };

  hardeningDisable = [ "all" ];

  buildPhase = ''
    make BUILD=debug BACNET_PORT=linux BACDL_DEFINE=-DBACDL_BIP=1 BACNET_DEFINES=" -DPRINT_ENABLED=1 -DBACFILE -DBACAPP_ALL -DBACNET_PROPERTY_LISTS"
  '';

  installPhase = ''
    mkdir $out
    cp -r bin $out/bin
  '';

  meta = with lib; {
    description = "BACnet open source protocol stack for embedded systems, Linux, and Windows";
    platforms = platforms.linux;
    license = licenses.gpl2;
    maintainers = with maintainers; [ WhittlesJr ];
  };
}
