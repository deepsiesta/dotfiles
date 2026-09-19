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

  flake.modules.homeManager.gui-base = {pkgs, ...}: {
    services.xembed-sni-proxy.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Sweet-Rainbow";
        package = pkgs.sweet-folders;
      };
    };

    home.packages = with pkgs; [
      candy-icons
    ];

    qt = {
      enable = true;
    };
  };
}
