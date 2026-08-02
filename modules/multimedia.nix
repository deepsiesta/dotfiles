{
  flake.modules.nixos.multimedia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      qimgv
      mpv
      (syncplay.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (pkgs.fetchpatch {
              name = "pyopenssl_fix.patch";
              url = "https://patch-diff.githubusercontent.com/raw/Syncplay/syncplay/pull/775.patch";
              hash = "sha256-6bJZtWgb9e7ZK51xjkghloIVQRdLI2UJiVa4fyxDa5w=";
            })
          ];
      }))
      spotify
      spotify-player
    ];
  };
}
