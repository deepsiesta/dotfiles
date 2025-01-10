{config, ...}: {
  xdg.configFile."doom" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home-manager/emacs/doom";
    recursive = true;
  };
}
