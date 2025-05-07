# dotfiles

## 方針

- できる限りXDG Base Directoryに従う
  - <https://wiki.archlinux.jp/index.php/XDG_Base_Directory>
- home-managerだとzshのインストールはできないらしい
  - 先にzshをインストールして切り替える必要あり
    - <https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH>
- 次にnixをインストール
  - <https://nixos.org/download/>
- 最後にhome-managerをインストール(init_home_nix.sh)

## home.nix変更時

- `home-manager switch`: 変更を適用
- `exec $SHELL -l`: シェル再起動

## 備考

### vscodeでの.nixのシンタックスハイライトについて

あんまり良さげな拡張機能がなかった
とりあえず.nixファイルはviで編集すればいいかな
