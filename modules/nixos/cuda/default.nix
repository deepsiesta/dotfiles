{pkgs, ...}: {
  # Enable CUDA support
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
}
