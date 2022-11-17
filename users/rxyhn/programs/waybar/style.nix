''
  * {
    all: unset;
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: Material Design Icons, Iosevka Nerd Font;
    font-size: 21px;
  }

  window#waybar {
    background-color: #303446;
    color: #c6d0f5;
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
    background-color: #414559;
  }

  #pulseaudio,
  #backlight {
    margin: 0px 8px;
    padding: 5px 0px;
    background-color: #414559;
  }

  #battery {
    margin: 0px 8px 6px 8px;
    padding: 5px 0px 10px 0px;
    border-radius: 0px 0px 8px 8px;
    background-color: #414559;
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
    background-color: #414559;
    padding: 10px 0px;
  }

  #custom-power {
    margin-bottom: 8px;
  }

  #custom-launcher {
    background-image: url("${./sakura.png}");
    background-size: 60%;
    background-position: center;
    background-repeat: no-repeat;
    margin-top: 8px;
  }

  #workspaces {
    font-size: 15px;
    background-color: #414559;
  }

  #custom-launcher,
  #clock {
    color: #c6d0f5;
    background-color: #414559;
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values (waybar #1351) */
    background-color: transparent;
    color: #8caaee;
    font-size: 21px;
    padding: 0px 0px;
    margin: 5px 0px;
    box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
    min-width: 0; /* Fix weird spacing in materia (waybar #450) */
  }

  #workspaces button:hover {
    color: #8caaee;
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #workspaces button.active {
    color: #e5c890;
  }

  #workspaces button.urgent {
    background-color: #e78284;
  }

  #clock {
    font-weight: 700;
    font-size: 21px;
    padding: 5px 0px;
    font-family: "Iosevka Term";
  }

  #custom-swallow {
    color: #f4b8e4;
  }

  #custom-todo {
    color: #c6d0f5;
  }

  #network {
    color: #99d1db;
  }

  #network.disconnected {
    color: #e78284;
  }

  #pulseaudio {
    color: #ca9ee6;
  }

  #pulseaudio.muted {
    color: #51576d;
  }

  #backlight {
    color: #8caaee;
  }

  #battery {
    color: #a6d189;
  }

  #battery.warning {
    color: #ef9f76;
  }

  @keyframes blink {
    to {
      background-color: #ffffff;
      color: #000000;
    }
  }

  #battery.critical:not(.charging) {
    color: #e78284;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }

  #custom-lock {
    color: #e5c890;
  }

  #custom-power {
    color: #e78284;
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
      background-color: #e78284;
      color: #414559;
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
