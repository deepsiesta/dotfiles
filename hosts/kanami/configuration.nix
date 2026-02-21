{
  flake.modules.nixos.kanami = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    imports = [
      ./hardware-configuration.nix
      inputs.self.modules.nixos.common
      inputs.self.modules.nixos.audio
      inputs.self.modules.nixos.fonts
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.gui
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.stylix
      inputs.self.modules.nixos.gaming
      inputs.self.modules.nixos.nvidia
      inputs.home-manager.nixosModules.default
      inputs.self.modules.nixos.neovim
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

    home-manager = {
      # Pass inputs to home-manager modules
      extraSpecialArgs = {inherit inputs;};
      users = {
        "siesta" = inputs.self.modules.homeManager.kanami;
      };
    };

    system.stateVersion = "24.05"; # Do not change this
  };

  flake.modules.homeManager.kanami = {
    lib,
    inputs,
    ...
  }: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "siesta";
    home.homeDirectory = "/home/siesta";

    home.stateVersion = "24.05"; # Do not change this

    imports = [
      inputs.self.modules.homeManager.common
      inputs.self.modules.homeManager.gui
      inputs.self.modules.homeManager.hyprland
      inputs.self.modules.homeManager.waybar
      inputs.self.modules.homeManager.fuzzel
      inputs.self.modules.homeManager.starship
      inputs.self.modules.homeManager.tmux
      inputs.self.modules.homeManager.nushell
      inputs.self.modules.homeManager.fastfetch
      inputs.self.modules.homeManager.stylix
    ];

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

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
