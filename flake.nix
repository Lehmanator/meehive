{
  description = "Nix / NixOS configs using snowfall-lib.";
  outputs = { std, hive, nixpkgs, self, ... }@inputs: hive.growOn
    {
      inherit inputs;
      nixpkgsConfig = { allowUnfree = true; };
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; with hive.blockTypes; [
        # modules implement - profiles activate - suites aggregate - configs get deployed
        #(functions "colmenaModules")
        #(functions "colmenaProfiles")
        #(functions "colmenaSuites")
        colmenaConfigurations
        #(functions "devshellModules")
        #(functions "devshellProfiles")
        #(functions "devshellSuites")
        (devshells "devshells")
        #(functions "diskoModules")
        #(functions "diskoProfiles")
        #(functions "diskoSuites")
        diskoConfigurations
        #(functions "darwinModules")
        #(functions "darwinProfiles")
        #(functions "darwinSuites")
        #darwinConfigurations
        #(functions "droidModules")
        #(functions "droidProfiles")
        #(functions "droidSuites")
        #(functions "droidConfigurations")
        #(functions "hardwareModules")
        (functions "hardwareProfiles")
        #(functions "hardwareSuites")
        #(functions "hardwareConfigurations")
        #(functions "homeModules")
        (functions "homeProfiles")
        #(functions "homeSuites")
        homeConfigurations
        #(functions "nixosModules")
        (functions "nixosProfiles")
        #(functions "nixosSuites")
        nixosConfigurations
        #(functions "nixvimModules")
        #(functions "nixvimProfiles")
        #(functions "nixvimSuites")
        #(functions "nixvimConfigurations")
        #(functions "robotnixModules")
        #(functions "robotnixProfiles")
        #(functions "robotnixSuites")
        #(functions "robotnixConfigurations")
        (functions "lib")
        (functions "overlays")
        (runnables "jobs")
        (runnables "apps")
        (installables "packages" { ci.publish = true; })
        (containers "containers" { ci.publish = true; })
        (files "examples")
        (data "templates")
      ];
    }
    {
      # soil
      devShells = std.harvest self [ "repo" "devshells" ];
    }
    {
      colmenaHive = hive.collect self "colmenaConfigurations";
      #darwinConfigurations = hive.collect self "darwinConfigurations";
      #darwinModules = hive.collect self "darwinModules";
      #darwinProfiles = hive.collect self "darwinProfiles";
      #darwinSuites = hive.collect self "darwinSuites";
      diskoConfigurations = hive.collect self "diskoConfigurations";
      #diskoModules = hive.collect self "diskoModules";
      #diskoProfiles = hive.collect self "diskoProfiles";
      #diskoSuites = hive.collect self "diskoSuites";
      hardwareConfigurations = hive.collect self "hardwareConfigurations";
      #hardwareModules = std.harvest self [ "lehmanator" "hardwareModules" ];
      hardwareProfiles = std.harvest self [ "lehmanator" "hardwareProfiles" ];
      #hardwareSuites = std.harvest self [ "lehmanator" "hardwareSuites" ];
      homeConfigurations = hive.collect self "homeConfigurations";
      #homeModules = std.harvest self [ "lehmanator" "homeModules" ];
      homeProfiles = std.harvest self [ "lehmanator" "homeProfiles" ];
      #homeSuites = std.harvest self [ "lehmanator" "homeSuites" ];
      nixosConfigurations = hive.collect self "nixosConfigurations";
      #nixosModules = std.harvest self [ "lehmanator" "nixosModules" ];
      nixosProfiles = std.harvest self [ "lehmanator" "nixosProfiles" ];
      #nixosSuites = std.harvest self [ "lehmanator" "nixosSuites" ];
      #nixvimConfigurations = hive.collect self "nixvimConfigurations";
      #nixvimModules = hive.collect self "nixvimModules";
      #nixvimProfiles = hive.collect self "nixvimProfiles";
      #nixvimSuites = hive.collect self "nixvimSuites";
      #   droidConfigurations = hive.collect self "droidConfigurations";
      #robotnixConfigurations = hive.collect self "robotnixConfigurations";
    };

  inputs = {
    # +---------+---Stable-------------+---Unstable-----------+
    # | nixpkgs | staging-23.05        | staging              |
    # | nixpkgs | staging-next-23.05   | staging-next         |
    # |   nixos | nixos-23.05          | nixos-unstable       |
    # |   nixos | nixos-23.05-small    | nixos-unstable-small |
    # |  darwin | nixpkgs-23.05-darwin |                      |
    # | nixpkgs | release-23.05        | nixpkgs-unstable     |
    # +---------+----------------------+-----------------------
    nixos-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos-stable-small.url = "github:nixos/nixpkgs/nixos-23.05-small";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";

    nixpkgs-stable.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-stable-staging.url = "github:nixos/nixpkgs/staging-23.05";
    nixpkgs-stable-staging-next.url = "github:nixos/nixpkgs/staging-next-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable-staging.url = "github:nixos/nixpkgs/staging";
    nixpkgs-unstable-staging-next.url = "github:nixos/nixpkgs/staging-next";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-gnome.url = "github:nixos/nixpkgs/gnome";

    stable.url = "github:nixos/nixpkgs/release-23.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    staging.url = "github:nixos/nixpkgs/staging";
    staging-next.url = "github:nixos/nixpkgs/staging-next";
    master.url = "github:nixos/nixpkgs/master";
    gnome.url = "github:nixos/nixpkgs/gnome";

    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-mobile = {
      url = "github:nixos/mobile-nixos";
      flake = false;
    };

    # --- nix-community ---
    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    namaka = {
      url = "github:nix-community/namaka";
      inputs = {
        haumea.follows = "haumea";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-init = {
      url = "github:nix-community/nix-init";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    patsh = {
      url = "github:nix-community/patsh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    robotnix = {
      url = "github:nix-community/robotnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    terraform-providers-bin = {
      url = "github:nix-community/nixpkgs-terraform-providers-bin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- Astro ---
    deadnix = { url = "github:astro/deadnix"; inputs.nixpkgs.follows = "nixpkgs"; };
    microvm = { url = "github:astro/microvm.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    openwrt-imagebuilder = { url = "github:astro/nix-openwrt-imagebuilder"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- cachix ---
    #devenv = {};

    # --- chuangzhu ---
    nixpkgs-gnome-apps.url = "github:chuangzhu/nixpkgs-gnome-apps";
    nixpkgs-gnome-mobile.url = "github:chuangzhu/nixpkgs-gnome-mobile";

    # --- DavHau ---
    #nix-portable = {};

    # --- DeterminateSystems ---
    # https://github.com/DeterminateSystems/nix-to-kubernetes
    fh = { url = "github:DeterminateSystems/fh"; inputs.nixpkgs.follows = "nixpkgs"; };
    flake-checker = { url = "github:DeterminateSystems/flake-checker"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-netboot-serve = { url = "github:DeterminateSystems/nix-netboot-serve"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-policy = { url = "github:DeterminateSystems/nix-policy"; inputs.nixpkgs.follows = "nixpkgs"; };
    nuenv = { url = "github:DeterminateSystems/nuenv"; inputs.nixpkgs.follows = "nixpkgs"; };
    vault-service = { url = "github:DeterminateSystems/nixos-vault-service"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- Divnix ---
    # call-flake, dmerge, incl, nosys,
    # flops, POP,
    # std, std-action, std-action-runner, std-data-collection, nix-cache-action
    # yants,
    std = {
      url = "github:divnix/std";
      inputs = {
        arion.follows = "arion";
        devshell.follows = "devshell";
        makes.follows = "makes";
        microvm.follows = "microvm";
        n2c.follows = "nix2container";
        nixago.follows = "nixago";
        nixpkgs.follows = "nixpkgs";
        terranix.follows = "terranix";
      };
    };
    hive = {
      url = "github:divnix/hive";
      inputs = {
        colmena.follows = "colmena";
        nixpkgs.follows = "nixpkgs";
        #disko.follows = "disko";
        #haumea.follows = "flops/haumea";
        #nixos-generators.follows = "nixos-generators";
      };
    };
    qnr.url = "github:divnix/quick-nix-registry";
    paisano-tui = { url = "github:paisano-nix/tui"; inputs.nixpkgs.follows = "nixpkgs"; };
    paisano = {
      url = "github:paisano-nix/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # https://github.com/dwarfmaster/arkenfox-nixos

    # --- edolstra ---

    # --- farcaller ---
    nixhelm = {
      url = "github:farcaller/nixhelm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-kube-generators = {
      url = "github:farcaller/nix-kube-generators";
    };
    nix-kube-modules = {
      url = "github:farcaller/nix-kube-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixdockertag = {
      url = "github:farcaller/nixdockertag";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- fluidattacks ---
    makes = { url = "github:fluidattacks/makes"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- GTrunSec ---
    flops = {
      url = "github:GTrunSec/flops";
    };
    omnibus = {
      url = "github:GTrunSec/omnibus";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    std-ext = {
      url = "github:GTrunSec/std-ext";
      inputs.std.follows = "std";
      inputs.flops.follows = "flops";
    };

    # --- hall ---
    kubenix = { url = "github:hall/kubenix"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- Helsinki-Systems
    #harmonia = { url = "github:helsinki-systems/harmonia"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- Hercules-CI ---
    #flake-parts = {};
    arion = { url = "github:Hercules-CI/arion"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- ipetkov ---
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- JakeHamilton ---
    # https://github.com/jakehamilton/config/blob/main/flake.nix

    # --- lnl7 ---
    darwin = { url = "github:lnl7/nix-darwin"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- Mic92 ---
    envfs = { url = "github:Mic92/envfs"; inputs.nixpkgs.follows = "nixpkgs"; };
    fast-flake-update = { url = "github:Mic92/fast-flake-update"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-fast-build = { url = "github:Mic92/nix-fast-build"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-update = { url = "github:Mic92/nix-update"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-shell = { url = "github:Mic92/nixos-shell"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix = { url = "github:Mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    vmsh = {
      url = "github:Mic92/vmsh"; # nixosModules: linux-ioregionfd
      inputs.nixpkgs.follows = "nixpkgs"; # packages: alpine-db, alpine-image, alpine-sec-scanner, alpine-sec-scanner-image, busybox-image, crosvm-example, fat-image, firecracker-example, kernel-deps, kvmtool-example, linux-ioregionfd, measurement-image, nixos-image, not-os-image, not-os-image_6_3, passwd-image, phoronix-image, phoronix-test-suite, qemu-example, vmsh, xfstests
    };

    # --- nlewo ---
    nix2container = { url = "github:nlewo/nix2container"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- Numtide ---
    devshell = { url = "github:numtide/devshell"; inputs.nixpkgs.follows = "nixpkgs"; };
    #flake-utils = { url = "github:numtide/flake-utils"; };
    #nixpkgs-unfree = {};
    nix-filter = { url = "github:numtide/nix-filter"; };
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
    };
    systemd-vaultd = { url = "github:numtide/systemd-vaultd"; inputs.nixpkgs.follows = "nixpkgs"; };
    treefmt = { url = "github:numtide/treefmt"; inputs.nixpkgs.follows = "nixpkgs"; };
    treefmt-nix = { url = "github:numtide/treefmt-nix"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- ryantm ---
    nixpkgs-update = { url = "github:ryantm/nixpkgs-update"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- rycee ---
    # --- samueldr ---

    # --- serokell ---
    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };

    # --- SnowfallOrg ---
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-cowsay = {
      url = "github:snowfallorg/cowsay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-docs = {
      url = "github:snowfallorg/docs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-dotbox = {
      url = "github:snowfallorg/dotbox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-frost = {
      url = "github:snowfallorg/frost";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-icehouse = {
      url = "github:snowfallorg/icehouse";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-quickjs = {
      url = "github:snowfallorg/quickjs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-templates = {
      url = "github:snowfallorg/templates";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-thaw = {
      url = "github:snowfallorg/thaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- SnowflakeLinux ---
    snowflake.url = "github:snowflakelinux/snowflake-modules";
    nix-data.url = "github:snowflakelinux/nix-data";
    snow.url = "github:snowflakelinux/snow";

    # --- terranix ---
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- Tweag ---
    jupyenv = {
      url = "github:tweag/jupyenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- vlinkz ---
    nix-editor.url = "github:vlinkz/nix-editor";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    mobile-nixos-flake.url = "github:vlinkz/mobile-nixos-flake";

    # --- Zhaofengli ---
    attic = {
      url = "github:zhaofengli/attic";
      # FIXME: A specific version of Rust is needed right now or
      # the build fails. Re-enable this after some time has passed.
      inputs.nixpkgs.follows = "unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # --- Others/Misc ---
    # carlthome/ml-runtimes      https://flakehub.com/flake/carlthome/ml-runtimes
    # ipetkov/crane              https://flakehub.com/flake/ipetkov/crane
    # kamadorueda/alejandra      https://flakehub.com/flake/kamadorueda/alejandra

  };

}
