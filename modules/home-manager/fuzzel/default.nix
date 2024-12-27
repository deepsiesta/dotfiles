{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 30;
        vertical-pad = 12;
        line-height = 28;
        font = "Noto Sans:size=12";
        launch-prefix = "uwsm-app --";
      };
      colors = {
        background = "000000cc";
        text = "ffffffff";
        selection = "121212dd";
        border = "0x30C0F0";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
