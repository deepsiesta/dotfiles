{
  flake.modules.nixos.sddm = {pkgs, ...}: let
    sddm-astronaut = pkgs.sddm-astronaut.override {
      themeConfig = {
        Font = "Noto Sans";
        AccentColor = "#FFFFFF";
        PartialBlur = false;
        FormPosition = "center";
        ForceHideCompletePassword = true;
      };
    };
  in {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm; # Use Qt6
        theme = "sddm-astronaut-theme";
        extraPackages = [sddm-astronaut];
      };
    };
    environment.systemPackages = [sddm-astronaut];
  };
}
