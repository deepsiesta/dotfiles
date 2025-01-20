{
  config,
  pkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
      ];
  };

  xdg.configFile."doom" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home-manager/emacs/doom";
    recursive = true;
  };
}
