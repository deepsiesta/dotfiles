{
  flake.modules.nixos.gui-base = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor.size = 24;
        keyboard = {
          layout = "us";
          variant = "altgr-intl";
        };
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
      };
    };
  };

  flake.modules.homeManager.gui-base = {
    config,
    pkgs,
    ...
  }: {
    services.xembed-sni-proxy.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
      gtk4.theme = null;
      gtk3.extraCss = ''
        @import url("noctalia.css");
      '';
      gtk4.extraCss = ''
        @import url("noctalia.css");
      '';
      iconTheme = {
        name = "Sweet-Rainbow";
        package = pkgs.sweet-folders;
      };
      font = {
        name = "Noto Sans";
        size = 12;
      };
    };

    home.packages = with pkgs; [
      candy-icons
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      qt5ctSettings = {
        Appearance = {
          color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
          custom_palette = true;
          icon_theme = "Sweet-Rainbow";
          style = "Fusion";
        };
      };
      qt6ctSettings = {
        Appearance = {
          color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
          custom_palette = true;
          icon_theme = "Sweet-Rainbow";
          style = "Fusion";
        };
      };
    };
  };
}
