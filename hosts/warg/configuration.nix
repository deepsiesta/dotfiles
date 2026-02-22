{
  flake.modules.nixos.warg = {
    config,
    lib,
    pkgs,
    inputs,
    ...
  }: let
    modules = [
      "common"
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
      users.siesta = {
        home.username = "siesta";
        home.homeDirectory = "/home/siesta";

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
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
}
