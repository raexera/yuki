{
  pkgs,
  inputs,
  themes,
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

      x.fraction = 0.5;
      y.fraction = 0.3;
      width.fraction = 0.5;
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

    extraCss = let
      inherit (themes.colorscheme) xcolors;
    in ''
      /* Global */
      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font Propo", sans-serif;
        font-size: 11pt;
        font-weight: 500;
        transition: 300ms;
      }

      /* Modules */
      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      /* Entry */
      #entry {
        background: ${xcolors.black3};
        border-radius: 100px;
        margin: 0.5rem;
        padding: 0.5rem;
      }

      /* Match  */
      #match.activatable {
        background: ${xcolors.black3};
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

      /* Hover and selected states */
      #match:selected,
      #match:hover,
      #plugin:hover {
        background: lighter(${xcolors.black3});
      }

      /* Main container */
      box#main {
        background: ${xcolors.black0};
        border-radius: 16px;
        padding: 0.5rem;
      }

      /* Plugin within list */
      list > #plugin {
        border-radius: 16px;
        margin: 0.5rem;
      }
    '';
  };
}
