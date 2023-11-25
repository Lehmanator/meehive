{ inputs, cell }: {
  wyse = {
    imports = [
      inputs.lanzaboote.nixosModules.lanzaboote
      #inputs.disko.nixosModules.disko
      #cell.diskoConfigurations.wyse
      cell.hardwareProfiles.wyse
      #cell.nixosProfiles.lanzaboote
      cell.nixosProfiles.default-packages
      cell.nixosProfiles.default-users
      cell.nixosProfiles.generators
      cell.nixosProfiles.kernel-zen
      cell.nixosProfiles.nix-config
      #cell.nixosProfiles.printing
      #cell.nixosProfiles.home-manager
    ];
    bee = {
      system = "x86_64-linux";
      home = inputs.home-manager;
      #darwin = inputs.nix-darwin;
      #wsl = inputs.nixos-wsl;
      #pkgs = import inputs.nixpkgs {
      #  inherit (inputs.nixpkgs) system;
      #  config.allowUnfree = true;
      #  overlays = [ ];
      #};
      #pkgs = cell.pkgs;
      pkgs = inputs.nixpkgs;
    };

    system.stateVersion = "23.11";

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    # Network Manager
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online = {
      enable = false;
      serviceConfig.TimeoutSec = 15;
      wantedBy = [ "network-online.target" ];
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

    # EID
    #services.pcscd.enable = true;
    #services.pcscd.plugins = [pkgs.acsccid]; # smartcard reader from ACS
    #environment.etc."chromium/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";
    #environment.etc."opt/chrome/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";

    # Tell p11-kit to load/proxy opensc-pkcs11.so, providing all available slots
    # (PIN1 for authentication/decryption, PIN2 for signing).
    #environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    #  module: ${pkgs.opensc}/lib/opensc-pkcs11.so
    #'';


    programs.starship.enable = true;
    programs.nix-ld.enable = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions = { enable = true; async = true; };
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

    services.sshd.enable = true;

    programs.ssh = {
      extraConfig = ''
        Host github.com
          User git
          Hostname github.com
          IdentityFile ~/.ssh/id_rsa
      '';
    };
  };
}
