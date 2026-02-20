{ flake.modules.homeManager.gui = {pkgs, ...}: {
  home.file = {
    ".local/share/thumbnailers/dds.thumbnailer".text = ''
      [Thumbnailer Entry]
      Exec=sh -c "${pkgs.imagemagick}/bin/convert -thumbnail x%s %i png:%o"
      MimeType=image/x-dds;
    '';
  };

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
    TerminalEmulatorDismissed=true
  '';

  programs = {
    kitty = {
      enable = true;
      settings = {
        shell = "nu";
        window_padding_width = 20;
        enable_audio_bell = "no";
        window_alert_on_bell = "no";
      };
      shellIntegration.enableFishIntegration = true;
    };
  };

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

  # Sweet Folders requires Candy Icons for non-folder icons
  home.packages = with pkgs; [
    candy-icons
  ];

  qt = {
    enable = true;
  };
}; }
