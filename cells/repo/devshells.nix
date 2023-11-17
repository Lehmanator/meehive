let
  inherit (inputs) nixpkgs std;
  inherit (inputs.hive) bootstrap;
  inherit (std.lib.dev) mkShell mkNixago;

  inherit (builtins) mapAttrs;

  withCategory = category: attrset: attrset // {inherit category;};
in
  mapAttrs (_: mkShell) {
    default = {...}: {
      name = "Apis Mellifera";
      nixago = with std.data.configs; [
        (mkNixago treefmt)
        (mkNixago lefthook)
        (mkNixago editorconfig)
        (mkNixago conform {data = {inherit (inputs) cells;};})
      ];
      imports = [bootstrap.shell.bootstrap];
      commands = [
        (withCategory "hexagon" {package = inputs.home.packages.home-manager;})
        (withCategory "hexagon" {package = inputs.colmena.packages.colmena;})
      ];
    };
  }

