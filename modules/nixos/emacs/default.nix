{pkgs, ...}: let
  emacs-pkg = pkgs.emacs30-pgtk;
in {
  # Emacs daemon
  # services.emacs = {
  #   enable = true;
  #   package = emacs-pkg;
  # };

  environment.systemPackages = [
    emacs-pkg
  ];
}
