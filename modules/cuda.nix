{
  flake.modules.nixos.cuda = {pkgs, ...}: {
    # Enable global CUDA support
    # Disabled as this makes Firefox, etc. build from source
    # nixpkgs.config.cudaSupport = true;

    environment.systemPackages = with pkgs; [
      (btop.override {cudaSupport = true;})
      ollama-cuda
    ];
  };
}
