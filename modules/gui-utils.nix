{
  flake.modules.nixos.gui-utils = {pkgs, ...}: {
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      bitwarden-desktop
      thud
      xarchiver
      discord
      gimp3
      qbittorrent
      insync
    ];
  };

  flake.modules.homeManager.gui-utils = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.terminal.quickAccessLines = lib.mkOption {
      type = lib.types.int;
      default = 32;
      description = "Number of lines for the quick access terminal";
    };

    config = {
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

      xdg.configFile."kitty/quick-access-terminal.conf".text = ''
        lines ${toString config.terminal.quickAccessLines}
        edge top
        hide_on_focus_loss yes
        kitty_override window_padding_width 20
        background_opacity 0.7
      '';

      programs.kitty = {
        enable = true;
        settings = {
          shell = "nu";
          window_padding_width = 20;
          enable_audio_bell = "no";
          window_alert_on_bell = "no";
        };
        keybindings = {
          "ctrl+shift+p>p" = "change_font_size all 18.0";
          "ctrl+shift+p>o" = "change_font_size all 0";
        };
        shellIntegration.enableFishIntegration = true;
      };
    };
  };
}
