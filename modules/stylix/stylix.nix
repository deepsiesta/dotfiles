{pkgs, ...}: {
  stylix = {
    enable = true;

    image = /home/siesta/Pictures/walls/current_wp.png;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    override = {
      base00 = "000000";
    };

    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
      };

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

    opacity = {
      applications = 0.9;
      desktop = 0.8;
      popups = 0.9;
      terminal = 0.8;
    };

    targets.nixvim.enable = false;
  };
}
