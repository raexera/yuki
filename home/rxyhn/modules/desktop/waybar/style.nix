{colorscheme}:
with colorscheme.colors; let
  OSLogo = builtins.fetchurl rec {
    name = "OSLogo-${sha256}.png";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in ''
  * {
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: Material Design Icons, monospace;
    font-size: 13px;
  }

  window#waybar {
    background-color: #${base00};
    transition-property: background-color;
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.5;
  }

  #workspaces {
    background-color: transparent;
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values (waybar #1351) */
    min-width: 0; /* Fix weird spacing in materia (waybar #450) */
    box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
    padding: 6px 18px;
    margin: 6px 3px;
    border-radius: 4px;
    background-color: #${base01};
    color: #${base05};
  }

  #workspaces button.active {
    color: #${base01};
    background-color: #${base05};
  }

  #workspaces button:hover {
   box-shadow: inherit;
   text-shadow: inherit;
   color: #${base01};
   background-color: #${base05};
  }

  #workspaces button.urgent {
    background-color: #${base0C};
  }

  #custom-launcher,
  #custom-weather,
  #custom-swallow,
  #custom-power,
  #custom-todo,
  #custom-weather,
  #battery,
  #backlight,
  #pulseaudio,
  #network,
  #clock,
  #tray {
    border-radius: 4px;
    margin: 6px 3px;
    padding: 6px 12px;
    background-color: #${base01};
    color: #${base00};
  }

  #custom-power {
    margin-right: 6px;
  }

  #custom-launcher {
    margin-left: 6px;
    padding: 6px 18px;
    background-image: url("${OSLogo}");
    background-size: 70%;
    background-position: center;
    background-repeat: no-repeat;
  }

  #custom-launcher,
  #custom-weather,
  #custom-todo {
    color: #${base05};
    background-color: #${base01};
  }

  #custom-swallow {
    color: #${base05};
  }

  #battery {
    background-color: #${base08};
  }

  @keyframes blink {
    to {
      background-color: #${base0C};
      color: #${base00};
    }
  }

  .warning,
  .critical,
  .urgent,
  #battery.critical:not(.charging) {
    background-color: #${base0C};
    color: #${base00};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }

  #backlight {
    background-color: #${base09};
  }

  #pulseaudio.microphone {
    background-color: #${base0A};
  }

  #pulseaudio {
    background-color: #${base0B};
  }

  #network {
    background-color: #${base0C};
  }

  #clock.date {
    background-color: #${base0D};
  }

  #clock {
    background-color: #${base0E};
  }

  #custom-power {
    background-color: #${base0F};
  }

  tooltip {
    font-family: "Inter", sans-serif;
    border-radius: 8px;
    padding: 20px;
    margin: 30px;
  }

  tooltip label {
    font-family: "Inter", sans-serif;
    padding: 20px;
  }
''
