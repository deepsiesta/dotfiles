{
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add trusted users for substituters
  nix.settings.trusted-users = ["root" "@wheel"];

  # Nix store optimization
  nix.settings.auto-optimise-store = true;

  # Garbage collection and nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--no-gcroots --keep 3 --keep-since 14d --optimise";
    flake = "/home/siesta/dotfiles";
  };

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

  security.polkit.enable = true;

  # Allow running AppImage files as normal executables
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    fastfetch
    playerctl
    imagemagick
    tmux
    tree
    fd
    ripgrep
    tldr
    btop
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.siesta = {
    isNormalUser = true;
    description = "Siesta";
    extraGroups = ["networkmanager" "video" "wheel"];
    # packages = with pkgs; [
    # ];
  };
}
