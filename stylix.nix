{pkgs, ...}: {
  stylix = {
    enable = true;

    image = /home/siesta/Pictures/walls/tmp6ug8m7_b_r4.png;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    override = {
      base00 = "000000";
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    opacity.terminal = 0.8;
  };
}
