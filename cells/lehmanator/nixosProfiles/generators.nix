{ inputs, cell }: { modulesPath, ... }:
{
  imports = [ inputs.nixos-generators.nixosModules.all-formats ];

  formatConfigs = {
    install-iso = {
      imports = [
        (inputs.nixpkgs + "/modules/nixos/installers/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
        (inputs.nixpkgs + "/modules/nixos/installers/cd-dvd/channel.nix")
      ];
    };
    iso = {
      imports = [
        (inputs.nixpkgs + "/modules/nixos/installers/cd-dvd/iso-image.nix")
      ];
    };
  };
}
