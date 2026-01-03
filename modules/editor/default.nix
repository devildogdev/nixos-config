{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      telescope-nvim
      plenary-nvim
      telescope-fzf-native-nvim
      catppuccin-nvim     
    ];
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      pyright
      eslint
      sqls
      nixd
      lua-language-server
      typescript-language-server
    ];
    extraLuaConfig = builtins.readFile ./nvim/init.lua;
  };
}
