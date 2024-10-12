{...}: {
  programs.fuzzel = {
    enable = true;
    #fuzel -b 00000095 -w 30 -y 12 -f "Noto"-14 --line-height=28 -t ffffffff -s 121212dd
    settings = {
      main = {
        width = 30;
        vertical-pad = 12;
        line-height = 28;
        # font = "Noto Sans:size=12";
      };
      # colors = {
      #   background = "000000cc";
      #   text = "ffffffff";
      #   selection = "121212dd";
      # };
    };
  };
}
