{
  flake.modules.nixos.thunar = {pkgs, ...}: {
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs; [thunar-archive-plugin thunar-volman];
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
  };
}
