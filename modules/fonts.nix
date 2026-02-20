{ flake.modules.nixos.fonts = { pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["FiraCode Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}; }
