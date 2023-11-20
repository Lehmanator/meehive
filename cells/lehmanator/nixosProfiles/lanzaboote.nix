{ inputs, cell }: { lib, ... }:
{
  #imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot = {
    lanzaboote = {
      enable = true;
      pkiKeys = "/etc/secureboot";
    };
    loader.systemd-boot.enable = lib.mkForce false;
  };
}
