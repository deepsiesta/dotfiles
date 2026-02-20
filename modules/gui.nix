{ flake.modules.nixos.gui = {
  pkgs,
  inputs,
  ...
}: {
  # Install firefox.
  programs.firefox.enable = true;

  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [thunar-archive-plugin thunar-volman];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable Obsidian plugin for Neovim
  # programs.nixvim.plugins.obsidian.enable = lib.mkForce true;

  environment.systemPackages = with pkgs; [
    kitty
    bitwarden-desktop
    qimgv
    thud
    xarchiver
    discord
    mpv
    syncplay
    gimp3
    (lutris.override {extraPkgs = pkgs: [winetricks];})
    (bottles.override {removeWarningPopup = true;})
    spotify
    qbittorrent
    insync
    kdePackages.okular
    obsidian
    # Codium
    vscodium-fhs
    # Gemini
    antigravity-fhs
    gemini-cli
    # Cursor
    code-cursor-fhs
    cursor-cli
  ];
}; 

flake.modules.homeManager.gui = {pkgs, ...}: {
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