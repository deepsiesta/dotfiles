{
  flake.modules.nixos.gaming = {
    pkgs,
    inputs,
    ...
  }: {
    # TODO: Remove the overlay once openldap is fixed upstream
    imports = [inputs.self.modules.nixos.openldap];

    # Game mode
    programs.gamemode.enable = true;

    # 32 bit libraries
    hardware.graphics.enable32Bit = true;

    # Install Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    environment.systemPackages = with pkgs; [
      protonplus
      (lutris.override {extraPkgs = _pkgs: [winetricks];})
      (bottles.override {removeWarningPopup = true;})
      faugus-launcher
      # Gstreamer
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
    ];
  };
}
