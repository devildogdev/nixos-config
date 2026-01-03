{ ... }:

{
  programs = {
    tmux = {
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
  };
}

