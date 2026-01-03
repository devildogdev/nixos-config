{ ... }:

{
  programs = {
    fzf = {
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
  };
}

