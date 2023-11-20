{ inputs, cell }: { config, pkgs, lib, ... }:
{
  imports = [ inputs.qnr.nixosModules.local-registry ];
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      allow-flake-config = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" "ca-derivations" ];
      builders-use-substitutes = true;
      trusted-substituters = [
        "https://numtide.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      trusted-users = [ "root" "@wheel" ];
    };
    localRegistry = {
      enable = true;
      cacheGlobalRegistry = true;
      noGlobalRegistry = false;
    };
  };
}
