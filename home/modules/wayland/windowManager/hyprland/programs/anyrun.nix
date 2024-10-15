{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        symbols
      ];

      width.fraction = 0.5;
      y.absolute = 5;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = 10;
    };

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 10,
          terminal: Some("kitty"),
        )
      '';
    };

    extraCss = ''
      @define-color foreground #D8DEE9;
      @define-color background #242933;
      @define-color background-alt #2E3440;
      @define-color background-focus #373E4C;

      * {
        all: unset;
        font:
          11pt Inter,
          sans-serif;
        transition: 200ms;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #entry {
        background: @background-alt;
        border-radius: 100px;
        margin: 0.5rem;
        padding: 0.5rem;
      }

      #match.activatable {
        background: @background-alt;
        padding: 0.5rem 1rem;
      }

      #match.activatable:first-child {
        border-radius: 16px 16px 0 0;
      }

      #match.activatable:last-child {
        border-radius: 0 0 16px 16px;
      }

      #match.activatable:only-child {
        border-radius: 16px;
      }

      #match:selected,
      #match:hover,
      #plugin:hover {
        background: @background-focus;
      }

      box#main {
        background: @background;
        border-radius: 16px;
        padding: 0.5rem;
      }

      list > #plugin {
        border-radius: 16px;
        margin: 0.5rem;
      }
    '';
  };
}
