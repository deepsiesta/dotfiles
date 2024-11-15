{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 30;
        vertical-pad = 12;
        line-height = 28;
      };
    };
  };
}
