{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      saveNoDups = true;
    };
    setOptions = [
      "NO_BEEP"
      "EXTENDED_GLOB"
      "NO_MATCH"
      "PROMPT_SUBST"
    ];
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/.nixos-config";
    };
    envExtra = ''
      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWSTASHSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWCOLORHINTS=true
      export GIT_PS1_STATESEPARATOR=""
    '';
    initContent = ''
      bindkey "^[[3~" delete-char
      bindkey "^?" backward-delete-char
      bindkey "^Y" end-of-line
      bindkey "^N" menu-complete
      bindkey "^P" reverse-menu-complete

      if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
        autoload -Uz add-zle-hook-widget
        function zle_application_mode_start { echoti smkx }
        function zle_application_mode_stop { echoti rmkx }
        add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
        add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
      fi

      zstyle ':completion:*' menu select

      nix-shell() {
        command nix-shell "$@" --run zsh
      }

      source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
      precmd() {
      local nix_prompt=""
      if [ -n "$IN_NIX_SHELL" ]; then
        nix_prompt="%F{2}[nix]%f "
      fi
      __git_ps1 "''${nix_prompt}%B%F{4}%3~%f%b" ' %# ' ' %s'
      }
    '';
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec river
      fi
    '';
  };
}
