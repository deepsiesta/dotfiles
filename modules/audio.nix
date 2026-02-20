{ flake.modules.nixos.audio = { ... }: {
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    #jack.enable = true;
    wireplumber.extraConfig = {
      # Fixes delay on audio start
      disable-session-timeout = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {"node.name" = "~alsa_input.*";}
              {"node.name" = "~alsa_output.*";}
            ];
            actions.update-props."session.suspend-timeout-seconds" = 0;
          }
        ];
      };
    };
  };
}; }
