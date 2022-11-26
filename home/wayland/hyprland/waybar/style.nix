{theme}:
with theme.colors; ''
  * {
    all: unset;
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: Material Design Icons, JetBrainsMono Nerd Font;
    font-size: 20px;
  }

  window#waybar {
    background-color: #${mantle};
    color: #${text};
    transition-property: background-color;
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #network {
    margin: 0px 8px;
    padding: 10px 0px 5px 0px;
    border-radius: 8px 8px 0px 0px;
    background-color: #${base};
  }

  #pulseaudio,
  #backlight {
    margin: 0px 8px;
    padding: 5px 0px;
    background-color: #${base};
  }

  #battery {
    margin: 0px 8px 6px 8px;
    padding: 5px 0px 10px 0px;
    border-radius: 0px 0px 8px 8px;
    background-color: #${base};
  }

  #custom-launcher,
  #custom-weather,
  #custom-swallow,
  #custom-power,
  #custom-todo,
  #custom-lock,
  #custom-weather,
  #clock,
  #workspaces {
    border-radius: 8px;
    margin: 6px 8px;
    background-color: #${base};
    padding: 10px 0px;
  }

  #custom-power {
    margin-bottom: 8px;
  }

  #custom-launcher {
    background-image: url("${./assets/nix-snowflake.png}");
    background-size: 60%;
    background-position: center;
    background-repeat: no-repeat;
    margin-top: 8px;
  }

  #workspaces {
    font-size: 15px;
    background-color: #${base};
  }

  #custom-launcher,
  #clock {
    color: #${text};
    background-color: #${base};
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values (waybar #1351) */
    background-color: transparent;
    color: #${blue};
    font-size: 21px;
    padding: 0px 0px;
    margin: 5px 0px;
    box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
    min-width: 0; /* Fix weird spacing in materia (waybar #450) */
  }

  #workspaces button:hover {
    color: #${blue};
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #workspaces button.active {
    color: #${yellow};
  }

  #workspaces button.urgent {
    background-color: #${red};
  }

  #clock {
    font-weight: 700;
    font-size: 20px;
    padding: 5px 0px;
  }

  #custom-swallow {
    color: #${mauve};
  }

  #custom-todo {
    color: #${text};
  }

  #network {
    color: #${sky};
  }

  #network.disconnected {
    color: #${red};
  }

  #pulseaudio {
    color: #${pink};
  }

  #pulseaudio.muted {
    color: #${overlay0};
  }

  #backlight {
    color: #${blue};
  }

  #battery {
    color: #${green};
  }

  #battery.warning {
    color: #${peach};
  }

  @keyframes blink {
    to {
      background-color: #ffffff;
      color: #000000;
    }
  }

  #battery.critical:not(.charging) {
    color: #${red};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }

  #custom-lock {
    color: #${yellow};
  }

  #custom-power {
    color: #${red};
  }

  tooltip {
    font-family: "Lato", sans-serif;
    border-radius: 8px;
    padding: 20px;
    margin: 30px;
  }

  tooltip label {
    font-family: "Lato", sans-serif;
    padding: 20px;
  }

  @keyframes blink_red {
    to {
      background-color: #${red};
      color: #${base};
    }
  }

  .warning,
  .critical,
  .urgent {
    animation-name: blink_red;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }
''
