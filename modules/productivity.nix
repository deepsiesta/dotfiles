{
  flake.modules.nixos.productivity = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      kdePackages.okular
      obsidian
    ];
  };
}
