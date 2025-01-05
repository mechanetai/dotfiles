{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER"; # 環境変数$USERを取得
  homeDir = builtins.getEnv "HOME"; # 環境変数$HOMEを取得
in
{ 
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.11"; 

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true; # zsh-completionsを有効化
    autosuggestion.enable = true; # zsh-autosuggestionsを有効化
    syntaxHighlighting.enable = true; # zsh-syntax-highlightingを有効化
    dotDir = ".config/zsh"; # zshの設定ファイルを格納するディレクトリを指定
    initExtra = ''
      nixDaemonPath="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      [ -e $nixDaemonPath ] && . $nixDaemonPath

      nixProfilePath="$HOME/.nix-profile/etc/profile.d/nix.sh"
      [ -e $nixProfilePath ] && . $nixProfilePath

      zshManagerPath="$HOME/.config/zsh/.zsh.d/zsh-d-manager.sh"
      [ -e $zshManagerPath ] && . $zshManagerPath
    ''; # nix(-daemon).shはNixの環境変数を読み込むためのスクリプト(home-managerを使うため)
};

  programs.starship.enable = true;
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gh
    fzf
    tree
    lunarvim
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    devbox
    gradle
    kotlin
    kotlin-native
];

  home.file = {
    ".config/nvim".source = "${homeDir}/dotfiles/.config/nvim";
    ".config/python".source = "${homeDir}/dotfiles/.config/python";
    ".config/zsh/.zsh.d".source = "${homeDir}/dotfiles/.config/zsh/.zsh.d";
    ".config/starship.toml".source = "${homeDir}/dotfiles/.config/starship.toml";
  };

  home.sessionVariables = {
    PYTHONSTARTUP = "${homeDir}/.config/python/pythonstartup.py";
  };

}
