{ inputs, cell }: { pkgs, ... }:
{
  # TODO: Add main user to groups for printing/scanning
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };
  services.system-config-printer.enable = true;
}
