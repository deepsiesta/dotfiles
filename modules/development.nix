{
  flake.modules.nixos.development = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.vscodium-fhs
      pkgs.opencode
    ];
  };
}
