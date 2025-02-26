# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
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
    ../../modules/nixos/gaming
    ../../modules/nixos/podman
    ../../modules/nixos/nvidia
    ../../modules/nixos/cuda
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/neovim/nixvim.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  hardware.cpu.intel.updateMicrocode = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "stargazer"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Corsair keyboard etc. support
  hardware.ckb-next.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Enable Obsidian plugin for Neovim
  programs.nixvim.plugins.obsidian.enable = lib.mkForce true;

  home-manager = {
    # Pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "siesta" = import ./home.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
