{
  flake.modules.nixos.stargazer = {
    pkgs,
    inputs,
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
      "cursor"
      "hyprland"
      "stylix"
      "gaming"
      "obs"
      "aagl"
      "podman"
      "nvidia"
      "cuda"
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
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    hardware.cpu.intel.updateMicrocode = true;

    # Enable firmware updates
    services.fwupd.enable = true;

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

    # Logitech wireless support/configuration
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # Corsair keyboard etc. support
    hardware.ckb-next.enable = true;

    # Xbox Controller
    hardware.xone.enable = true;

    # Enable OpenGL
    hardware.graphics.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    home-manager.users.siesta = {
      host.monitors = [
        {
          name = "HDMI-A-1";
          width = 3840;
          height = 2160;
          refresh = 60;
          x = -1920;
          scale = 2;
        }
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
          workspace = builtins.concatLists (builtins.genList (
              i: let
                wleft = 2 * i + 1;
                wright = 2 * i + 2;
              in [
                "${toString wleft}, monitor:HDMI-A-1"
                "${toString wright}, monitor:DP-1"
              ]
            )
            5);
          exec-once = [
            "uwsm app -- ckb-next --background"
            "uwsm app -- solaar --window hide"
            "uwsm app -- steam -silent"
          ];
        };
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };
}
