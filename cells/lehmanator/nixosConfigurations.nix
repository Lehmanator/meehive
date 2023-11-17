{
  wyse = {
    imports = [
      inputs.nixos-generators.nixosModules.all-formats
      inputs.qnr.nixosModules.local-registry
      cell.hardwareConfigurations.wyse
    ];
    bee = {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixpkgs {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
        overlays = [
        ];
      };
    };
    nix = {
      package = pkgs.nixUnstable;
      settings = {
        allow-flake-config = true;
        experimental-features = ["nix-command" "flakes" "repl-flake" "ca-derivations"];
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
        allowed-users = ["@wheel"];
        trusted-users = ["root" "@wheel"];
      };
      localRegistry = {
        enable = true;
        cacheGlobalRegistry = true;
        noGlobalRegistry = false;
      };
    };
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    services.sshd.enable = true;
    users = {
      defaultUserShell = pkgs.zsh;
      users.root = {
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCo3Q3odpbDCcOxKeiqE5YX4sWmSGynXz3Nog0IuQbPfj8/4bCaeQMPMYggu7Txj9Q935teDi0C6mLkeprn5Q0vsZwglX/lAXaMEv3QgnzPzIxple0Ns7buyaIP38JNAHCd6qNMpLXsWU1CrKkX9qOY3CSzb127xMY9IemW2GzIUD8v3SCrmUoEJg3cqZJ3zK21V3SbSyAwf1EJT/jfggksC7gSMOmvkFPJ/8E1L/J7l/+yplS+4cmFoznbVgIyp49Vl6SGE+jay4yc/BAxzmx+x3tPn4zLeZVRswmx6sRZZXY+U+jKeZ5/0HFETtz87rW4cXW95531wpsVufu8M8eqvdOGVIR1a3HYaM82I7Enm95lKXuyoijwYlsVQP+DTWHtzpXNHZekSQjpmlR31pHyF/h7nON2DzCwcdrz+NOvXmQgighXvuwWVF0MmZCHJDJYS4P/RDG2HKztuqxiH5dxYCWyVIcYuS2awHXb+zhOFPi+UvhezgJPMU1gX+djXZGorN87HditBLfFmMckmT1MCU0jzenn4boPE25j5TXRCRCXTI9TMFOgzOS87amE/w8cUFK2WQiIa60SLkNdHy8k4W0aQfjGxEL9ijsB+JKpzgKFOv0EKIBYY8Z4i822RvZ9L7WCDK0BQe0jmkwp0ZUDnST2XY3NMqprVZNHFWKz7w== sam@fw"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw"
        ];
      };
      users.sam = {
        shell = pkgs.zsh;
        isNormalUser = true;
        initialPassword = "changeme-sam";
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCo3Q3odpbDCcOxKeiqE5YX4sWmSGynXz3Nog0IuQbPfj8/4bCaeQMPMYggu7Txj9Q935teDi0C6mLkeprn5Q0vsZwglX/lAXaMEv3QgnzPzIxple0Ns7buyaIP38JNAHCd6qNMpLXsWU1CrKkX9qOY3CSzb127xMY9IemW2GzIUD8v3SCrmUoEJg3cqZJ3zK21V3SbSyAwf1EJT/jfggksC7gSMOmvkFPJ/8E1L/J7l/+yplS+4cmFoznbVgIyp49Vl6SGE+jay4yc/BAxzmx+x3tPn4zLeZVRswmx6sRZZXY+U+jKeZ5/0HFETtz87rW4cXW95531wpsVufu8M8eqvdOGVIR1a3HYaM82I7Enm95lKXuyoijwYlsVQP+DTWHtzpXNHZekSQjpmlR31pHyF/h7nON2DzCwcdrz+NOvXmQgighXvuwWVF0MmZCHJDJYS4P/RDG2HKztuqxiH5dxYCWyVIcYuS2awHXb+zhOFPi+UvhezgJPMU1gX+djXZGorN87HditBLfFmMckmT1MCU0jzenn4boPE25j5TXRCRCXTI9TMFOgzOS87amE/w8cUFK2WQiIa60SLkNdHy8k4W0aQfjGxEL9ijsB+JKpzgKFOv0EKIBYY8Z4i822RvZ9L7WCDK0BQe0jmkwp0ZUDnST2XY3NMqprVZNHFWKz7w== sam@fw"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw"
        ];
      };
    };

    # Network Manager
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online = {
      enable = false;
      serviceConfig.TimeoutSec = 15;
      wantedBy = ["network-online.target"];
    };

    # Desktop Environment
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    sound.enable = true;
    sound.mediaKeys.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.sane.enable = true;

    # Printing
    services.printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
    services.system-config-printer.enable = true;

    # EID
    #services.pcscd.enable = true;
    #services.pcscd.plugins = [pkgs.acsccid]; # smartcard reader from ACS
    #environment.etc."chromium/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";
    #environment.etc."opt/chrome/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";

    # Tell p11-kit to load/proxy opensc-pkcs11.so, providing all available slots
    # (PIN1 for authentication/decryption, PIN2 for signing).
    environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
      module: ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';


    environment.systemPackages = with pkgs; [
      chromium
      firefox

      element-desktop

      age
      tree
      direnv
      git
      gh
      ghq
      rnix-lsp
      alejandra

      # Wrapper script to tell to Chrome/Chromium to use p11-kit-proxy to load
      # security devices, so they can be used for TLS client auth.
      # Each user needs to run this themselves, it does not work on a system level
      # due to a bug in Chromium:
      #
      # https://bugs.chromium.org/p/chromium/issues/detail?id=16387
      (pkgs.writeShellScriptBin "setup-browser-eid" ''
        NSSDB="''${HOME}/.pki/nssdb"
        mkdir -p ''${NSSDB}
        ${pkgs.nssTools}/bin/modutil -force -dbdir sql:$NSSDB -add p11-kit-proxy \
          -libfile ${pkgs.p11-kit}/lib/p11-kit-proxy.so
      '')

      sbctl
    ];

    programs.starship.enable = true;
    programs.nix-ld.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions = {enable=true; async=true;};
      syntaxHighlighting.enable = true;
      shellInit = ''
        eval "$(direnv hook zsh)"
      '';
    };
    programs.git = {
      enable = true;
      config = {
        user.name = "Sam Lehman";
        user.email = "github@samlehman.dev";
        init.defaultBranch = "main";
        pull.rebase = true;
        rebase.autosquash = true;
        rerere.enable = true;
      };
    };
    programs.ssh = {
      extraConfig = ''
        Host github.com
          User git
          Hostname github.com
          IdentityFile ~/.ssh/id_rsa
      '';
    };
    programs.chromium.enable = true;

    system.stateVersion = "23.11";

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
  };
}
