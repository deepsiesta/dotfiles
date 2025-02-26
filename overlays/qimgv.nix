{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      qimgv = prev.qimgv.override {
        opencv4 = prev.opencv4.override {enableCuda = false;};
      };
    })
  ];
}
