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
        name = "FiraCode Nerd Font";
        size = 12;
      };
      settings = {
        shell = "fish";
        background_opacity = "0.8";
        window_padding_width = 15;
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
      name = "candy-icons";
      # Merge Candy Icons and Sweet Folders into the same package
      package = pkgs.candy-icons.overrideAttrs (oldAttrs: {
        postInstall = ''
          cp ${pkgs.sweet-folders}/share/icons/Sweet-Rainbow/Places/* $out/share/icons/candy-icons/places/48
        '';
      });
    };
    font = {
      name = "Noto Sans";
      size = 12;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
}
