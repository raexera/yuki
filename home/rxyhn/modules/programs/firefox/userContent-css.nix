''
  :root {
    scrollbar-width: none !important;
  }

  @-moz-document url(about:privatebrowsing) {
    :root {
      scrollbar-width: none !important;
    }
  }

   @-moz-document url("about:newtab"), url("about:home") {
    body {
      background-color: #181825 !important;
    }

    .search-wrapper .logo-and-wordmark .logo {
      background-image: url("https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png") !important;
      background-size: 100% !important;
      height: 250px !important;
      width: 500px !important;
    }

    .icon-settings,
    .body-wrapper,
    .SnippetBaseContainer,
    .search-handoff-button,
    .search-wrapper .logo-and-wordmark .wordmark,
    .search-wrapper .search-inner-wrapper,
    .search-wrapper input {
      display: none !important;
    }
  }
''
