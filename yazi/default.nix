{ pkgs, ... }:

{
  home.packages = with pkgs; [
    resvg
    poppler
    autojump
    ueberzugpp
    ffmpeg
    ripdrag
    trash-cli
    ripgrep
    fzf
    eza
    bat
    fd
    neovim
    plocate
    zoxide
    ouch
    lazygit
    (writeShellScriptBin "fzf-bat-preview" (builtins.readFile ./scripts/fzf-bat-preview))
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    initLua = ''
      require("zoxide"):setup({ update_db = true })
      require("full-border"):setup({ type = ui.Border.ROUNDED })
      require("searchjump"):setup({
        only_current = true,
        unmatch_fg = "reset",
        match_str_fg = "reset",
        match_str_bg = "reset",
        first_match_str_fg = "reset",
        first_match_str_bg = "reset",
        label_fg = "#000000",
        label_bg = "#CCFF88",
      })
    '';
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      piper = pkgs.yaziPlugins.piper;
      chmod = pkgs.yaziPlugins.chmod;
    };

    flavors = {
      kanagawa = pkgs.fetchFromGitHub {
        owner = "dangooddd";
        repo = "kanagawa.yazi";
        rev = "main";
        sha256 = "sha256-Yz0zRVzmgbrk0m7OkItxIK6W0WkPze/t09pWFgziNrw=";
      };
    };

    theme = {
      flavor = {
        dark = "kanagawa";
      };
    };
  };

  xdg.configFile."yazi" = {
    source = ./yazi;
    recursive = true;
  };

  xdg.configFile."yazi/plugins" = {
    source = ./plugins;
    recursive = true;
  };

  home.sessionVariables = {
    YAZI_ZOXIDE_OPTS = "--height=70% --margin=2% --padding=1% --border=rounded --info=default --layout=default --no-preview --ansi --no-sort";
  };
}
