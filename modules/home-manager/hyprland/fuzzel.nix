{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 30;
        vertical-pad = 12;
        line-height = 28;
        font = "Noto Sans:size=12";
      };
      colors = {
        background = "000000cc";
        text = "ffffffff";
        selection = "121212dd";
      };
    };
  };
}
