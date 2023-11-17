{
  sam = {
    imports = [
      #cell.homeProfiles.
    ];
    bee = {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = inputs.nixpkgs;
    };
    home = {
      username = "sam";
      homeDirectory = "/home/sam";
      stateVersion = "23.11";
    };
    manual = {
      manpages.enable = false;
      html.enable = false;
      json.enable = false;
    };
    programs.git = {
      userName = "Sam Lehman";
      userEmail = "github@samlehman.dev";
    };
  };
}
