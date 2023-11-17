{
  wyse = {
    imports = [
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      cell.diskoConfigurations.wyse
    ];
    networking.useDHCP = lib.mkDefault true;
    boot.lanzaboote = {
      enable = true;
      pkiKeys = "/etc/secureboot";
    };
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci"];
    boot.kernelModules = ["kvm-intel"];
    boot.kernelPackages = pkgs.linuxPackages_zen;
    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;
  };
}
