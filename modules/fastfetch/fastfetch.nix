{
  config,
  pkgs,
  ...
}: {
  programs.fastfetch = {
    enable = true;
  };
  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
}
