{ flake.modules.homeManager.nushell = {
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
  };
}; }
