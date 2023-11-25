{ inputs, cell }: { lib, ... }:
{
  imports = [
    #inputs.disko.nixosModules.disko
    #inputs.nixos-hardware.nixosModules.common-pc-ssd
    #cell.diskoConfigurations.lehmanator-wyse
    #cell.diskoConfigurations.wyse
  ];
  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];
  };
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}
