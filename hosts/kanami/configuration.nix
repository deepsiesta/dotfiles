{
  flake.modules.nixos.kanami = {
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
      "gui"
      "hyprland"
      "stylix"
      "gaming"
      "nvidia"
      "neovim"
      "waybar"
      "fuzzel"
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
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
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

    # Enable OpenGL
    hardware.graphics.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    # Old GPUs cannot use the open kernel module
    hardware.nvidia.open = lib.mkForce false;

    home-manager.users.siesta = {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            "DP-1, 2560x1440@144, 0x0, 1"
          ];
          input = {
            numlock_by_default = lib.mkForce false;
          };
        };
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };
}
