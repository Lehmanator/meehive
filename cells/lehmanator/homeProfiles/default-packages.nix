{ inputs, cell }: { pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = [
    pkgs.bat
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.lsd
    pkgs.ripgrep
  ];
}
