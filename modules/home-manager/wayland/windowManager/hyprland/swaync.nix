{
  services.swaync = {
    enable = true;
    systemd.enable = true;
    settings = {
      positionX = "left";
      positionY = "top";
      layer = "overlay";
      controlCenterLayer = "top";
      layerShell = true;
      cssPriority = "application";
      controlCenterMarginTop = 0;
      controlCenterMarginBottom = 0;
      controlCenterMarginRight = 0;
      controlCenterMarginLeft = 0;
      notification2faAction = true;
      notificationInlineReplies = false;
      notificationIconSize = 64;
      notificationBodyImageHeight = 100;
      notificationBodyImageWidth = 200;
      timeout = 10;
      timeoutLow = 5;
      timeoutCritical = 0;
      fitToScreen = true;
      relativeTimestamps = true;
      controlCenterWidth = 500;
      controlCenterHeight = 600;
      notificationWindowWidth = 500;
      keyboardShortcuts = true;
      imageVisibility = "when-available";
      transitionTime = 200;
      hideOnClear = false;
      hideOnAction = true;
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
        "mpris"
      ];
      widgetConfig = {
        inhibitors = {
          text = "Inhibitors";
          buttonText = "Clear All";
          clearAllButton = true;
        };
        title = {
          text = "Notifications";
          clearAllButton = true;
          buttonText = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          maxLines = 5;
          text = "Label Text";
        };
        mpris = {
          imageSize = 96;
          imageRadius = 12;
        };
      };
    };
  };
}
