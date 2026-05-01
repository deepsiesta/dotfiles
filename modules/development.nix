{
  flake.modules.nixos.development = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vscodium-fhs
      llm-agents.opencode
    ];
  };
}
