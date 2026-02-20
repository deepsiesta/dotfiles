{ flake.modules.homeManager.stylix = { pkgs, ... }: {
  stylix = {
    targets.hyprlock.enable = false;
    targets.waybar.enable = false;
  };
}; }
