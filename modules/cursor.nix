{
  flake.modules.nixos.cursor = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      code-cursor-fhs
      cursor-cli
    ];
  };
}
