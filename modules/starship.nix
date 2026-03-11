{
  flake.modules.homeManager.starship = {lib, ...}: {
    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$cmd_duration"
          "$line_break"
          "$nix_shell"
          "$python"
          "$character"
        ];
        directory = {
          style = "blue";
        };
        character = {
          success_symbol = "[❯](green)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](purple)";
        };
        git_branch = {
          format = "[ $branch]($style) ";
          style = "bright-black";
        };
        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };
        git_state = {
          format = "\([$state( $progress_current/$progress_total)]($style)\) ";
          style = "bright-black";
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };
        nix_shell = {
          format = "[󱄅 $name]($style) ";
          style = "cyan";
        };
        python = {
          format = "[ $virtualenv]($style) ";
          style = "bright-black";
        };
      };
    };
  };
}
