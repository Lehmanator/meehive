{ inputs, cell }: { pkgs, ... }:
{
  imports = [ ];

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
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
  home.sessionVariables.BAT_STYLE = "plain";
  # TODO: Configure LESS, PAGER, MANPAGER, etc.
}
