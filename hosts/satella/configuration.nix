# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/common
    ../../modules/nixos/audio
    ../../modules/nixos/fonts
    ../../modules/nixos/sddm
    ../../modules/nixos/hyprland
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/neovim/nixvim.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  hardware.cpu.amd.updateMicrocode = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "satella"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.light.enable = true;

  # Emacs daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  hardware.graphics.enable = true;

  home-manager = {
    # Backup existing files
    # backupFileExtension = "hm-backup";
    # Pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "siesta" = import ./home.nix;
    };
  };

  # Game mode
  programs.gamemode.enable = true;

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    fastfetch
    pwvucontrol
    playerctl
    qimgv
    hyprpicker
    hyprshot
    wl-clipboard
    swww
    kitty
    inputs.ghostty.packages.x86_64-linux.default
    ranger
    tmux
    tree
    fd
    # Gstreamer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
