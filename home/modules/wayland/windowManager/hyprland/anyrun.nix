{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        symbols
        translate
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

    extraCss = ''
      * {
        all: unset;
        font: 11pt Inter, sans-serif;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #entry {
        background: alpha(#ffffff, 0.05);
        border: 1px solid alpha(#ffffff, 0.1);
        border-radius: 1rem;
        margin: 0.5rem;
        padding: 0.5rem;
      }

      #match.activatable {
        background: alpha(#ffffff, 0.05);
        padding: 0.5rem 1rem;
      }

      #match.activatable:first-child {
        border-radius: 1rem 1rem 0 0;
      }

      #match.activatable:last-child {
        border-radius: 0 0 1rem 1rem;
      }

      #match:selected,
      #match:hover,
      #plugin:hover {
        background: alpha(#ffffff, 0.1);
        transition: all 0.3s steps(12);
      }

      box#main {
        background: alpha(#000000, 0.5);
        border-radius: 1rem;
        padding: 0.5rem;
      }

      list > #plugin {
        border-radius: 1rem;
        margin: 0.5rem;
      }
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 10,
          terminal: Some("${config.home.sessionVariables.TERMINAL}"),
        )
      '';

      "translate.ron".text = ''
        Config(
          prefix: ":tr",
          language_delimiter: ">",
          max_entries: 5,
        )
      '';
    };
  };
}
