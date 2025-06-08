{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER"; # 環境変数$USERを取得
  homeDir = builtins.getEnv "HOME"; # 環境変数$HOMEを取得

  # Common paths
  nixDaemonPath = "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh";
  nixProfilePath = "${homeDir}/.nix-profile/etc/profile.d/nix.sh";
  zshManagerPath = "${homeDir}/.config/zsh/.zsh.d/zsh-d-manager.sh";
in
{
  home = {
    stateVersion = "25.05";
    username = username;
    homeDirectory = homeDir;
    packages = with pkgs; [
      git
      gh
      fzf
      tree
      nerd-fonts.fira-code
      devbox
      sqlfluff
      nixfmt-rfc-style # for VSCode format
      uv
      volta
      zoxide
    ];
    # 実態のhome.nixとの相対位置から、特定の位置へのシンボリックリンクを貼る
    file = {
      ".config/nvim".source = ../nvim;
      ".config/python".source = ../python;
      ".config/zsh/.zsh.d".source = ../zsh/.zsh.d;
      ".config/starship.toml".source = ../starship.toml;
    };
    sessionVariables = {
      PYTHONSTARTUP = "${homeDir}/.config/python/pythonstartup.py";
      VOLTA_HOME = "${homeDir}/.volta";
    };
    sessionPath = [
      "$VOLTA_HOME/bin"
    ];
    shellAliases = {
      cd = "z";
    };
  };
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true; # zsh-completionsを有効化
      autosuggestion.enable = true; # zsh-autosuggestionsを有効化
      syntaxHighlighting.enable = true; # zsh-syntax-highlightingを有効化
      dotDir = ".config/zsh"; # zshの設定ファイルを格納するディレクトリを指定
      initContent = ''
        export VOLTA_HOME="${homeDir}/.volta"
        export PYTHONSTARTUP="${homeDir}/.config/python/pythonstartup.py"
        export PATH="$VOLTA_HOME/bin:$PATH"
        [ -e ${nixDaemonPath} ] && . ${nixDaemonPath}
        [ -e ${nixProfilePath} ] && . ${nixProfilePath}
        [ -e ${zshManagerPath} ] && . ${zshManagerPath}
        eval "$(zoxide init zsh)"
      ''; # nix(-daemon).shはNixの環境変数を読み込むためのスクリプト(home-managerを使うため)
    };

    starship.enable = true;
    home-manager.enable = true;
  };
}
