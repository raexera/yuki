''
  /*
  ┌─┐┬┌┬┐┌─┐┬  ┌─┐
  └─┐││││├─┘│  ├┤
  └─┘┴┴ ┴┴  ┴─┘└─┘
  ┌─┐┌─┐─┐ ┬
  ├┤ │ │┌┴┬┘
  └  └─┘┴ └─
  */

  :root {
    --srf-primary: #1e1e2e;
    --srf-secondary: #181825;
    --srf-text: #cdd6f4;
    --srf-accent: #cba6f7;
  }

  window,
  #main-window,
  #toolbar-menubar,
  #TabsToolbar,
  #PersonalToolbar,
  #navigator-toolbox,
  #sidebar-box {
    background-color: var(--srf-primary) !important;
    -moz-appearance: none !important;
    background-image: none !important;
    border: none !important;
    box-shadow: none !important;
  }

  ::selection {
    background-color: var(--srf-accent);
    color: var(--srf-primary);
  }

  :root {
    --tabs-border: transparent !important;
  }

  .tab-background {
    border: none !important;
    border-radius: 0!important;
    margin: 0!important;
    margin-left: -1.6px!important;
    padding: 0!important;
  }

  .tab-background[selected='true'] {
    -moz-appearance: none !important;
    background-image: none !important;
    background-color: var(--srf-secondary)!important;
  }

  .tabbrowser-tab {
    border-radius: 15px 15px 0px 0px / 15px 15px 0px 0px !important;
  }

  .tabbrowser-tabs {
    border: none !important;
    opacity: 0 !important;
  }

  .tabbrowser-tab::before, .tabbrowser-tab::after{
    opacity: 0 !important;
    border-left: none !important;
  }

  .titlebar-placeholder {
    border: none !important;
  }

  .tab-line {
    display: none !important;
  }

  #back-button,
  #forward-button,
  #whats-new-menu-button,
  #star-button,
  #pocket-button,
  #save-to-pocket-button
  #pageActionSeparator,
  #pageActionButton,
  #reader-mode-button,
  #urlbar-zoom-button,
  #identity-box,
  #PanelUI-button,
  #tracking-protection-icon-container {
    display: none !important;
  }

  #context-navigation,
  #context-savepage,
  #context-pocket,
  #context-sendpagetodevice,
  #context-selectall,
  #context-viewsource,
  #context-inspect-a11y,
  #context-sendlinktodevice,
  #context-openlinkinusercontext-menu,
  #context-bookmarklink,
  #context-savelink,
  #context-savelinktopocket,
  #context-sendlinktodevice,
  #context-searchselect,
  #context-sendimage,
  #context-print-selection,
  #context_bookmarkTab,
  #context_moveTabOptions,
  #context_sendTabToDevice,
  #context_reopenInContainer,
  #context_selectAllTabs,
  #context_closeTabOptions {
    display: none !important;
  }

  #save-to-pocket-button {
    visibility: hidden !important;
  }

  .titlebar-spacer {
    display: none !important;
  }

  .tabbrowser-tab:not([pinned]) .tab-close-button {
    display: none !important;
  }

  .tabbrowser-tab:not([pinned]) .tab-icon-image {
    display: none !important;
  }

  #navigator-toolbox::after {
    border-bottom: 0px !important;
    border-top: 0px !important;
  }

  #nav-bar {
    background: var(--srf-secondary) !important;
    border: none !important;
    box-shadow: none !important;
    margin-top: 0px !important;
    border-top-width: 0px !important;
    margin-bottom: 0px !important;
    border-bottom-width: 0px !important;
  }

  #history-panel,
  #sidebar-search-container,
  #bookmarksPanel {
    background: var(--srf-primary) !important;
  }

  #search-box {
    -moz-appearance: none !important;
    background: var(--srf-primary) !important;
    border-radius: 6px !important;
  }

  #sidebar-search-container {
    background-color: var(--srf-primary) !important;
  }

  #sidebar-icon {
    display: none !important;
  }

  .sidebar-placesTree {
    color: var(--srf-text) !important;
  }

  #sidebar-switcher-target {
    color: var(--srf-text) !important;
  }

  #sidebar-header {
    background: var(--srf-primary) !important;
  }

  #sidebar-box {
    --sidebar-background-color: var(--srf-primary) !important;
  }

  #sidebar-splitter {
    border: none !important;
    opacity: 1 !important;
    background-color: var(--srf-primary) !important;
  }

  .urlbarView {
    display: none !important;
  }

  #urlbar-input-container {
    background-color: var(--srf-secondary) !important;
    border: 1px solid rgba(0, 0, 0, 0) !important;
  }

  #urlbar-container {
    margin-left: 8px !important;
  }

  #urlbar[focused='true'] > #urlbar-background {
    box-shadow: none !important;
  }

  .urlbarView-url {
    color: var(--srf-text) !important;
  }
''
