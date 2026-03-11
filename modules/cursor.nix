{
  flake.modules.nixos.cursor = {
    pkgs,
    inputs,
    ...
  }: {
    nixpkgs.overlays = [inputs.llm-agents.overlays.default];

    environment.systemPackages = with pkgs; [
      code-cursor-fhs
      llm-agents.cursor-agent
    ];
  };
}
