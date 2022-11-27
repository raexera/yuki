{theme}:
with theme.colors; ''
  * {
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: Material Design Icons, JetBrainsMono Nerd Font;
    font-size: 17px;
  }

  window#waybar {
    background-color: #${mantle};
    transition-property: background-color;
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.5;
  }

  #workspaces {
   background-color: #${base};
   margin: 6px 0px;
   border-radius: 4px;
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values (waybar #1351) */
    min-width: 0; /* Fix weird spacing in materia (waybar #450) */
    box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
    padding: 5px 10px;
    color: #${blue};
  }

  #workspaces button.active {
    color: #${mantle};
    background-color: #${mauve};
    border-radius: 4px;
  }

  #workspaces button:hover {
   box-shadow: inherit;
   text-shadow: inherit;
   color: #${mantle};
   background-color: #${mauve};
   border-radius: 4px;
  }

  #workspaces button.urgent {
    background-color: #${red};
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
  #clock
  {
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
    background-image: url("${../assets/waybar/nix-snowflake.png}");
    background-size: 70%;
    background-position: center;
    background-repeat: no-repeat;
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
      background-color: #${red};
      color: #${base};
    }
  }

  .warning,
  .critical,
  .urgent,
  #battery.critical:not(.charging) {
    background-color: #${red};
    color: #${base};
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
''
