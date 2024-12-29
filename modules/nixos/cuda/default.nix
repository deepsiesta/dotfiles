{pkgs, ...}: {
  # Enable CUDA support
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    (ollama.override {acceleration = "cuda";})
  ];
}
