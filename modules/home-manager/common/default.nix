{pkgs, ...}: {
  # home.packages = [];

  home.file = {
    ".local/share/thumbnailers/dds.thumbnailer".text = ''
      [Thumbnailer Entry]
      Exec=sh -c "${pkgs.imagemagick}/bin/convert -thumbnail x%s %i png:%o"
      MimeType=image/x-dds;
    '';
  };

  programs = {
    git = {
      enable = true;
      userName = "Siesta";
      userEmail = "20047950+deepsiesta@users.noreply.github.com";
    };
    # btop.enable = true;
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
    carapace = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -x CLICOLOR 1 # Make tree output colored
        fish_add_path ~/.config/emacs/bin
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      '';
    };
    ranger = {
      enable = true;
      settings = {
        column_ratios = "1,3,3";
        preview_images = true;
        preview_images_method = "kitty";
      };
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

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
