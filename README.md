Kasama's dotfiles
=================

How to install
--------------

Dotfiles installation provided by [dotty](https://github.com/vibhavp/dotty).

first of all, clone this repo locally
```sh
git clone --recursive git@github.com:Kasama/dotfiles
cd dotfiles
```
to install the dotfiles
```sh
./dotty/dotty.py dottyrc.json
```
you can add the `-r` option to replace existing files and folders
```sh
./dotty/dotty.py -r dottyrc.json
```

List of included configuration files
------------------------------------

- yaourt
- git
- X
- terminator
- [zsh](https://github.com/Kasama/prezto) (~/.zprezto)
- [nvim](https://github.com/Kasama/nvim) (~/.config/nvim)
- [tmux](https://github.com/Kasama/tmux) (~/tmux)
- [themes](https://github.com/Kasama/gtk-config) (~/.themes)
- [compiz](https://github.com/Kasama/compiz-config) (~/.config/compiz)
- [emerald](https://github.com/Kasama/emerald-config) (~/.emerald)
- [scripts](https://github.com/Kasama/scripts) (~/scripts)
