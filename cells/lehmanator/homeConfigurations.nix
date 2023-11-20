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
      packages = with pkgs; [
        bat
        eza
        fd
        fzf
        lsd
        ripgrep
      ];
    };
    manual = {
      manpages.enable = false;
      html.enable = false;
      json.enable = false;
    };
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
      config = {
        map-syntax = [
          "*.props:Java Properties"
        ];
        pager = "less -FR";
        theme = "ansi"; # Works well in both light/dark mode
      };
      #syntaxes = {};
      #themes = {};
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 40%"];
      #colors = { # https://github.com/junegunn/fzf/wiki/Color-schemes
      #  "bg" = "";
      #  "bg+" = "";
      #  "fg" = "";
      #  "fg+" = "";
      #};
      #defaultCommand = "";
      defaultOptions = [
        "--ansi"
        "--layout=reverse"
        "--info=inline-right"
        "--min-height=10"
        "--margin=0"
        "--padding=0"
      ];
      #changeDirWidgetCommand = "fd --type d";
      changeDirWidgetOptions = [
        "--preview='ltree {} | head -300'"
        "--prompt=\"\${PWD/\${HOME}/~} > \""
      ];
      #fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [
        "--height=20%"
        "--preview='bat {} --color=always --style=numbers,changes'"
        "--preview-window=right:50%,border-rounded"
        "--prompt=\"\${PWD/\${HOME}/~} > \""
      ];
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
    };
    programs.git = {
      userName = "Sam Lehman";
      userEmail = "github@samlehman.dev";
    };
    programs.zsh = {
      shellAliases = {
        F = "fd --type files --color always --exclude .git --follow --hidden";
        D = "fd --type directories --color always --exclude .git --follow --hidden";
        B = "bat --color=always --style=numbers,changes";
        etree = "eza -l --tree --color-scale --color=always --time-style=relative --git --hyperlink --no-permissions --no-filesize --no-user";
        ltree = "lsd --tree -l --git --blocks git,name,date,size,user,group,permission --total-size --date relative --color always --depth 4 --almost-all --size short --permission octal";
        fz  = "F | fzf --ansi --preview='bat {} --color=always --style=numbers' --prompt='files > '";
        fzg = "F | fzf --ansi --preview='bat {} --color=always --style=numbers,changes' --prompt='files > '";
        fzd = "D | fzf --ansi --preview='ltree {}' --prompt='dirs > '";
      };
    };
    programs.less = {
      enable = true;
      #keys = ''
      #  s    back-line
      #  t    forw-line
      #'';
    };
    programs.lesspipe.enable = true;
    programs.lf = {
      enable = true;
      #cmdKeybindings = {};
      #commands = {};
      #extraConfig = ''
      #'';
      #keybindings = {};
      #previewer = {
      #  keybinding = "";
      #  source = ""; # Path
      #};
      #settings = {};
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      BAT_STYLE = "plain";
    };
  };
}
