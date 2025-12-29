{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
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
      vim = "nvim";
    };
    envExtra = ''
      export LESSHISTFILE=-
      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWSTASHSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWUPSTREAM="auto"
      export GIT_PS1_SHOWCOLORHINTS=true
      export GIT_PS1_STATESEPARATOR=""
    '';
    initContent = ''
      bindkey "^[[3~" delete-char
      bindkey "^?" backward-delete-char
      bindkey "^N" menu-complete
      bindkey "^P" reverse-menu-complete
      
      if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
      	autoload -Uz add-zle-hook-widget
      	function zle_application_mode_start { echoti smkx }
      	function zle_application_mode_stop { echoti rmkx }
      	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
      	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
      fi

      source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
      precmd() { __git_ps1 '%B%F{4}%3~%f%b' ' %# ' ' %s'}
    '';
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec river
      fi
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      header = "#f38ba8";
      bg = "#000000";
      "bg+" = "#313244";
      hl = "#f38ba8";
      "hl+" = "#f38ba8";
      fg = "#cdd6f4";
      "fg+" = "#cdd6f4";
      selected-bg = "#45475a";
      prompt = "#cba6f7";
      spinner = "#f5e0dc";
      info = "#cba6f7";
      pointer = "#f5e0dc";
      marker = "#b4befe";
    };
    defaultOptions = [
      "--multi"
    ];
  };
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 1;
    extraConfig = ''
      unbind C-b
      set -g renumber-windows on
      setw -g pane-base-index 1
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel
      bind P paste-buffer
      unbind '"'
      unbind %
      bind | split-window -h
      bind - split-window -v
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      set -g status-left-length 13
      set -g status-style fg=green,bg=black
      set -g message-style fg=yellow,bg=black
      set -g message-command-style fg=yellow,bg=black
    '';
    focusEvents = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-Space";
    terminal = "tmux-256color";
  };
  programs.nnn = {
    enable = true;
  };
}
