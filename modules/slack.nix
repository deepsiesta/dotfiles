{ flake.modules.nixos.slack = { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    slack
  ];
}; }
