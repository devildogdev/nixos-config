{ config, pkgs, ... }:

{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
	end_of_line = "lf";
	insert_final_newline = true;
	trim_trailing_whitespace = true;
	indent_style = "space";
	indent_size = 2;
      };
      "*.{c,h,go,py,sql}" = {
        indent_size = 4;
      };
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim
      telescope-fzf-native-nvim
      catppuccin-nvim
    ];
    extraPackages = with pkgs; [
      tree-sitter
      ripgrep
      fd
      gcc
      pyright
      sqls
      nixd
      lua-language-server
      typescript-language-server
      clang-tools
      zls
      marksman
      gopls
      bash-language-server
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
