{
  flake.modules.homeManager.nushell = {
    config,
    pkgs,
    ...
  }: {
    programs.nushell = {
      enable = true;
      configFile.text = /* nu */ ''
        let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
        }

        let zoxide_completer = {|spans|
          $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
        }

        let external_completer = {|spans|
          match $spans.0 {
            z | zi => $zoxide_completer
            __zoxide_z | __zoxide_zi => $zoxide_completer
            _ => $carapace_completer
          } | do $in $spans
        }

        # Allow nonfree packages with nix run --impure
        $env.NIXPKGS_ALLOW_UNFREE = "1"

        # Make tree show colored output
        $env.CLICOLOR = 1

        $env.config = {
          show_banner: false
          completions: {
            external: {
              completer: $external_completer
            }
          }
        }
      '';
    };
  };
}
