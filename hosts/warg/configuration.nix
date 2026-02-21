{
  flake.modules.nixos.warg = {
    config,
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      ./hardware-configuration.nix
      inputs.self.modules.nixos.common
      inputs.home-manager.nixosModules.default
      inputs.self.modules.nixos.neovim
    ];

    # Firmware upgrades
    hardware.enableRedistributableFirmware = false;
    hardware.firmware = [pkgs.raspberrypiWirelessFirmware];

    # ZRAM
    zramSwap.enable = true;

    # Swapfile
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 4 * 1024;
      }
    ];

    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
    boot.loader.grub.enable = false;
    # Enables the generation of /boot/extlinux/extlinux.conf
    boot.loader.generic-extlinux-compatible.enable = true;

    networking.hostName = "warg"; # Define your hostname.

    # Prevent NetworkManager from pulling X/Wayland as a dependency
    networking.networkmanager.plugins = lib.mkForce [];

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "siesta" = inputs.self.modules.homeManager.warg;
      };
    };

    # Use fish as default shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "24.05"; # Do not change this
  };

  flake.modules.homeManager.warg = {inputs, ...}: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "siesta";
    home.homeDirectory = "/home/siesta";

    home.stateVersion = "24.05"; # Do not change this

    imports = [
      inputs.self.modules.homeManager.common
      inputs.self.modules.homeManager.starship
      inputs.self.modules.homeManager.tmux
      inputs.self.modules.homeManager.nushell
      inputs.self.modules.homeManager.fastfetch
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
