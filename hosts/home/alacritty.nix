{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 16.0;
          bold.family = "Inconsolata";
          bold_italic.family = "Inconsolata";
          italic.family = "Inconsolata";
          normal.family = "Inconsolata";
        };
        scrolling.history = 10000;
        window = {
          decorations = "none";
          dynamic_title = true;
          opacity = 0.9;
          startup_mode = "Maximized";
          title = "Alacritty";
          class = {
            general = "Alacritty";
            instance = "Alacritty";
          };
          dimensions = {
            columns = 0;
            lines = 0;
          };
          padding = {
            x = 2;
            y = 2;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
      };
      theme = "dracula";
    };
  };
}
