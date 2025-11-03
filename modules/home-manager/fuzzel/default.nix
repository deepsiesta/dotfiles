{lib, ...}: {
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
      colors = lib.mkForce {
        background = "000000cc";
        text = "ffffffff";
        selection = "121212dd";
        selection-text = "30c0f0dd";
        border = "30c0f0ff";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
