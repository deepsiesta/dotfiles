{
  flake.modules.nixos.satella = {
    config,
    lib,
    pkgs,
    inputs,
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
      "slack"
      "docker"
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
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      (inputs.self.lib.loadHostModules modules "siesta")
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
      # Pass inputs to home-manager modules
      extraSpecialArgs = {inherit inputs;};
      users.siesta = {
        home.username = "siesta";
        home.homeDirectory = "/home/siesta";

        wayland.windowManager.hyprland = {
          settings = {
            bindel = [
              " , XF86MonBrightnessUp, exec, light -A 10"
              " , XF86MonBrightnessDown, exec, light -U 10"
            ];
          };
        };
        programs.waybar = {
          settings = {
            mainBar = {
              modules-right = lib.mkForce ["tray" "wireplumber" "battery" "clock"];
            };
          };
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };
}
