{ config, lib, pkgs, ... }: {
  options = { programming.enable = lib.mkEnableOption "enable programming"; };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      # languages
      # .NET 8 SDK
      dotnetCorePackages.sdk_8_0_4xx-bin
      gcc
      gnumake
      go
      lua5_4
      lua54Packages.luarocks
      (runCommand "lua5.1-bin" { } ''
        mkdir -p $out/bin
        ln -s ${lua5_1}/bin/lua $out/bin/lua5.1
        ln -s ${lua5_1}/bin/lua $out/bin/lua51
        ln -s ${lua5_1}/bin/luac $out/bin/luac5.1
        ln -s ${lua5_1}/bin/luac $out/bin/luac51
      '')
      nodejs
      python3
      uv
      rustup

      # programming tools
      fzf
      mise
      neovim
      ripgrep
      tmux
      tree-sitter
      git-lfs
      android-tools
    ];
  };
}
