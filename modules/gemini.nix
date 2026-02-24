{
  flake.modules.nixos.gemini = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      antigravity-fhs
      gemini-cli
    ];
  };
}
