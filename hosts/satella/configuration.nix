{ inputs, ... }: { flake.modules.nixos.satella = {
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # Include the results of the hardware scan.
    inputs.self.modules.nixos.common
    inputs.self.modules.nixos.audio
    inputs.self.modules.nixos.fonts
    inputs.self.modules.nixos.sddm
    inputs.self.modules.nixos.gui
    inputs.self.modules.nixos.hyprland
    inputs.self.modules.nixos.stylix
    inputs.self.modules.nixos.gaming
    inputs.self.modules.nixos.slack
    inputs.self.modules.nixos.docker
    inputs.home-manager.nixosModules.default
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.self.modules.nixos.neovim
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  hardware.cpu.amd.updateMicrocode = true;

  # Enable firmware updates
  services.fwupd.enable = true;

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

  # Brightness control
  programs.light.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  home-manager = {
    # Backup existing files
    # backupFileExtension = "hm-backup";
    # Pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "siesta" = inputs.self.modules.homeManager.satella;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}; }
