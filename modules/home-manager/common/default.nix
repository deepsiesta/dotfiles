{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userName = "Siesta";
      userEmail = "20047950+deepsiesta@users.noreply.github.com";
    };
    carapace = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -x CLICOLOR 1 # Make tree output colored
        fish_add_path ~/.config/emacs/bin
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      '';
    };
  };

  # home.sessionVariables = {
  # EDITOR = "nvim"; # nixvim handles this
  # };
}
