{theme}:
with theme.colors; ''
  * {
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: Material Design Icons, Iosevka Nerd Font;
    font-size: 18px;
  }

  window#waybar {
    background-color: #${mantle};
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.5;
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
  #workspaces {
    border-radius: 4px;
    margin: 6px 0px;
    padding: 6px 12px;
    background-color: #${base};
    color: #${mantle};
  }

  #custom-power {
    margin-right: 6px;
  }

  #custom-launcher {
    margin-left: 6px;
    padding: 6px 18px;
    background-image: url("${./assets/nix-snowflake.png}");
    background-size: 70%;
    background-position: center;
    background-repeat: no-repeat;
  }

  #workspaces {
    background-color: #${base};
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values (waybar #1351) */
    background-color: transparent;
    color: #${blue};
    margin: 0px 6px;
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

  #custom-launcher,
  #custom-weather,
  #custom-todo
  {
    color: #${mauve};
    background-color: #${base};
  }

  #custom-swallow {
    color: #${mauve};
  }


  #battery {
    background-color: #${mauve};
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

  #pulseaudio {
    background-color: #${gradient0};
  }

  #pulseaudio.muted {
    color: #${overlay0};
  }

  #backlight {
    background-color: #${gradient1};
  }

  #network {
    background-color: #${gradient2};
  }

  #network.disconnected {
    color: #${red};
  }

  #clock {
    background-color: #${gradient3};
  }

  #custom-power {
    background-color: #${blue};
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
