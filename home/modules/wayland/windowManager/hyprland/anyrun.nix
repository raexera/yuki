{
  config,
  inputs,
  pkgs,
  themes,
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

    extraCss = let
      inherit (themes.colorscheme) xcolors;
    in ''
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
        background: ${xcolors.black3};
        border-radius: 1rem;
        margin: 0.5rem;
        padding: 1rem;
      }

      #match.activatable {
        padding: 0.5rem 1rem;
        background: ${xcolors.black3};
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
        border-radius: 1rem;
        background: ${xcolors.blue};
      }

      box#main {
        background: alpha(${xcolors.black0}, 0.3);
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
