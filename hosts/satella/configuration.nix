{
  flake.modules.nixos.satella = {
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

    system.stateVersion = "24.05"; # Do not change this
  };

  flake.modules.homeManager.satella = {
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
}
