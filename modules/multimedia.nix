{
  flake.modules.nixos.multimedia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      qimgv
      mpv
      syncplay
      spotify
    ];
  };
}
