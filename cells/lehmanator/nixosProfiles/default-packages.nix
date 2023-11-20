{ inputs, cell }: { pkgs, ... }:
{
  imports = [ ];
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

  programs.chromium.enable = true;
}
