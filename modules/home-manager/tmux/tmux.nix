{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.nushell}/bin/nu";
    shortcut = "a";
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.tokyo-night-tmux
    ];
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      # Sane splits
      bind-key \- split-window
      bind-key \\ split-window -h
      # Set theme
      set -g @tokyo-night-tmux_window_id_style none
      set -g @tokyo-night-tmux_pane_id_style none
      set -g @tokyo-night-tmux_zoom_id_style none
      set -g @tokyo-night-tmux_show_music 1
      set -g status-position top
      # Transparent background on status bar
      set -g status-bg default
    '';
  };
}
