let
  inherit (inputs.hive) bootstrap;
in {
  installer = {
    bee.system = "x86_64-linux";
    bee.pkgs = inputs.nixos.legacyPackages;
    imports = [bootstrap.profiles.bootstrap];
    nix.registry.hive.flake = {inherit (inputs.self) outPath;};
  };
}

