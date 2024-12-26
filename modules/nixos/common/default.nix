{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.siesta = {
    isNormalUser = true;
    description = "Siesta";
    extraGroups = ["networkmanager" "video" "wheel"];
    packages = with pkgs; [
      waybar
      networkmanagerapplet
      fuzzel
      btop
      discord
      mpv
      syncplay
      gimp
      (lutris.override {extraPkgs = pkgs: [winetricks];})
      bottles
      spotify
      qbittorrent
      insync
      okular
      emacs30-pgtk
      fd
      ripgrep
      tldr
    ];
  };
}
