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
      "gui"
      "hyprland"
      "stylix"
      "gaming"
      "obs"
      "aagl"
      "podman"
      "nvidia"
      "cuda"
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
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            "HDMI-A-1, 3840x2160@60, -1920x0, 2"
            "DP-1, 2560x1440@144, 0x0, 1"
          ];
          workspace =
            [
              "special:scratchpad, name:scratchpad, monitor:DP-1"
            ]
            ++ (
              # Bind odd workspaces to left screen, even workspaces to right screen
              builtins.concatLists (builtins.genList (
                  i: let
                    wleft = 2 * i + 1;
                    wright = 2 * i + 2;
                  in [
                    "${toString wleft}, monitor:HDMI-A-1"
                    "${toString wright}, monitor:DP-1"
                  ]
                )
                5) # Applies rules to workspaces 1 .. 10
            );
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
