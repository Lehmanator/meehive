{ inputs, cell }: { lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
}
