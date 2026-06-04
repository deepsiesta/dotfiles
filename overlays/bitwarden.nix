{
  flake.modules.nixos.bitwarden-overlay = _: {
    nixpkgs.overlays = [
      (final: prev: {
        bitwarden-desktop = prev.bitwarden-desktop.override {electron_39 = final.electron_39-bin;};
      })
    ];
  };
}
