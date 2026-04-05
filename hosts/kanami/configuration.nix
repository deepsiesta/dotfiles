{
  flake.modules.nixos.kanami = {
    config,
    pkgs,
    inputs,
    lib,
    ...
  }: let
    modules = [
      "common"
      "audio"
      "fonts"
      "sddm"
      "gui-utils"
      "gui-base"
      "thunar"
      "multimedia"
      "productivity"
      "development"
      "gemini"
      "hyprland"
      "stylix"
      "gaming"
      # "nvidia"
      "neovim"
      "starship"
      "tmux"
      "nushell"
      "fastfetch"
    ];
  in {
    imports = [
      ./hardware-configuration.nix
      (inputs.self.lib.loadHostModules modules "siesta")
    ];

    # Kernel
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12; # Last LTS version with working wifi driver
    hardware.cpu.intel.updateMicrocode = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = "kanami"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Required by wireless card
    hardware.usb-modeswitch.enable = true;
    boot.initrd.kernelModules = ["8852au"];
    boot.extraModulePackages = [
      config.boot.kernelPackages.rtl8852au
      config.boot.kernelPackages.rtl8852bu
    ];
    # environment.systemPackages = [pkgs.linuxKernel.packages.linux_5_15.rtw89];
    services.udev.extraRules =
      # Switch card from storage mode to WiFi mode.
      ''
        ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${lib.getExe pkgs.usb-modeswitch} -K -v 0bda -p 1a2b"
      '';

    # Enable OpenGL
    hardware.graphics.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    # Old GPUs cannot use the open kernel module
    # host.nvidia.legacy = true;

    home-manager.users.siesta = {
      host.monitors = [
        {
          name = "DP-1";
          width = 2560;
          height = 1440;
          refresh = 144;
          scale = 1;
        }
      ];
      wayland.windowManager.hyprland = {
        settings = {
          input = {
            numlock_by_default = lib.mkForce false;
          };
        };
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };
}
