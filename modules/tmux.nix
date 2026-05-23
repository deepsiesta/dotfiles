{
  flake.modules.homeManager.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.nushell}/bin/nu";
      shortcut = "a";
      clock24 = true;
      baseIndex = 1;
      # From tmux-sensible
      escapeTime = 0;
      historyLimit = 50000;
      terminal = "screen-256color";
      focusEvents = true;
      keyMode = "emacs";
      mouse = true;
      aggressiveResize = true;
      extraConfig = let
        window_status_format = ''#I: #{?#{m:ssh*,#{pane_current_command}},#(ps -t #{pane_tty} -o args= | grep '^ssh ' | sed 's/.* //'),#W}'';
        zoomed_icon = "  ";
      in
        # tmux
        ''
          # From tmux-sensible
          set -g display-time 4000
          set -g status-interval 5
          bind C-p previous-window
          bind C-n next-window
          bind R source-file '~/.config/tmux/tmux.conf'
          bind a last-window
          # vi navigation
          bind-key h select-pane -L
          bind-key j select-pane -D
          bind-key k select-pane -U
          bind-key l select-pane -R
          # Split using - and | keys
          bind-key \- split-window
          bind-key \\ split-window -h
          # Theme settings
          set -g status-position top
          set -g status-style bg=default,fg=default
          set -g status-justify left
          set -g status-left "[   #{session_name} ] "
          set -g status-left-style "fg=blue"
          set -g status-left-length 32
          set -g status-right "%Y-%m-%d ❬ %H:%M"
          set -g status-right-style "fg=cyan"
          set -g window-status-format "[ ${window_status_format} ]"
          set -g window-status-current-format "[ ${window_status_format}#{?window_zoomed_flag,${zoomed_icon},} ]"
          set -g window-status-current-style "fg=yellow,bold"
          set -g window-status-separator "  "
        '';
    };
  };
}
