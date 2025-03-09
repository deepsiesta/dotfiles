{pkgs, ...}: {
  home.file = {
    ".local/share/thumbnailers/dds.thumbnailer".text = ''
      [Thumbnailer Entry]
      Exec=sh -c "${pkgs.imagemagick}/bin/convert -thumbnail x%s %i png:%o"
      MimeType=image/x-dds;
    '';
  };

  programs = {
    kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font Light";
        size = 12;
      };
      settings = {
        shell = "fish";
        background_opacity = "0.8";
        window_padding_width = 20;
        enable_audio_bell = "no";
        window_alert_on_bell = "no";
      };
      shellIntegration.enableFishIntegration = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark";
    };
    iconTheme = {
      name = "Sweet-Rainbow";
      package = pkgs.sweet-folders;
    };
    font = {
      name = "Noto Sans";
      size = 12;
    };
  };

  # Sweet Folders requires Candy Icons for non-folder icons
  home.packages = with pkgs; [
    candy-icons
  ];

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
}
