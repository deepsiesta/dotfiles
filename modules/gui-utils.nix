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

  flake.modules.homeManager.gui-utils = {pkgs, ...}: {
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

    programs.kitty = {
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
}
