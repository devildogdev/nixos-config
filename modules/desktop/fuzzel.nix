{ ... }:

{
  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Hack Nerd Font Mono:size 13";
          dpi-aware = "no";
          icons-enabled = "no";
        };
        colors = {
          background = "000000ff";
          text = "cdd6f4ff";
          prompt = "bac2deff";
          placeholder = "7f849cff";
          input = "cdd6f4ff";
          match = "74c7ecff";
          selection = "585b70ff";
          selection-text = "cdd6f4ff";
          selection-match = "74c7ecff";
          counter = "7f849cff";
          border = "74c7ecff";
        };
        border = {
          width = 2;
          radius = 0;
        };
      };
    };
  };
}

