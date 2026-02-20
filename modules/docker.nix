{ flake.modules.nixos.docker = { ... }: {
  # In /etc/nixos/configuration.nix
  virtualisation.docker = {
    enable = true;
  };

  # Optional: Add your user to the "docker" group to run docker without sudo
  users.users.siesta.extraGroups = ["docker"];
}; }
