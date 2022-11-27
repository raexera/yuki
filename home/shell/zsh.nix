{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";

    history = {
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      code = "$HOME/Documents/code";
      dots = "$HOME/Documents/code/dotfiles";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      music = "$HOME/Music";
      media = "/run/media/$USER";
      nixpkgs = "$HOME/Documents/code/git/nixpkgs";
    };

    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char
    '';

    initExtra = ''
      export PATH="''${HOME}/.local/bin:''${HOME}/go/bin:''${HOME}/.npm/bin:''${PATH}"
      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '

      # Correct spelling for commands
      setopt correct

      # turn off the infernal correctall for filenames
      unsetopt correctall

      # Set some history options
      setopt append_history
      setopt extended_history
      setopt hist_expire_dups_first
      setopt hist_ignore_all_dups
      setopt hist_ignore_dups
      setopt hist_ignore_space
      setopt hist_reduce_blanks
      setopt hist_save_no_dups
      setopt hist_verify
      setopt INC_APPEND_HISTORY
      unsetopt HIST_BEEP

      # Share your history across all your terminal windows
      setopt share_history

      # Set some options about directories
      setopt pushd_ignore_dups
      setopt AUTO_CD

      # Add some completions settings
      setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
      setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
      setopt AUTO_MENU         # Show completion menu on a successive tab press.
      setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
      setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
      unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.

      # Miscellaneous settings
      setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
      setopt extended_glob # Enable more powerful glob features

      # Search history based on what's typed in the prompt
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # Completion
      zstyle ':completion:*' menu select
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' verbose true
      zstyle ':completion:complete:*:options' sort false
      _comp_options+=(globdots)

      export FZF_DEFAULT_OPTS="
      --color fg:#${theme.colors.text}
      --color fg+:#${theme.colors.surface1}
      --color bg:#${theme.colors.mantle}
      --color bg+:#${theme.colors.mantle}
      --color hl:#${theme.colors.blue}
      --color hl+:#${theme.colors.blue}
      --color info:#${theme.colors.surface2}
      --color prompt:#${theme.colors.green}
      --color spinner:#${theme.colors.blue}
      --color pointer:#${theme.colors.blue}
      --color marker:#${theme.colors.blue}
      --color border:#${theme.colors.surface2}
      --color header:#${theme.colors.blue}
      --prompt ' | '
      --pointer ''
      --layout=reverse
      --border horizontal
      --height 40
      "

      FZF_TAB_COMMAND=(
        ${pkgs.fzf}/bin/fzf
        --ansi
        --expect='$continuous_trigger' # For continuous completion
        --nth=2,3 --delimiter='\x00'  # Don't search prefix
        --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
        --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
        '--query=$query'   # $query will be expanded to query string at runtime.
        '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
      )

      zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
      zstyle ':fzf-tab:complete:_zlua:*' query-string input
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
        TERM_TITLE=$'\e]0;%n@%m: %1~\a'
          ;;
      *)
          ;;
      esac

      function run() {
        nix run nixpkgs#$@
      }

      precmd() {
        printf '\033]0;%s\007' "$(dirs)"
      }

      command_not_found_handler() {
        printf 'Command not found ->\033[32;05;16m %s\033[0m \n' "$0" >&2
          return 127
      }
    '';

    shellAliases = {
      rebuild = "sudo nix-store --verify; sudo nixos-rebuild --install-bootloader switch --flake .#; bat cache --build";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      nixtest = "sudo nixos-rebuild test --flake .#graphene --fast";
      bloat = "nix path-info -Sh /run/current-system";
      cat = "${pkgs.bat}/bin/bat --style=plain";
      grep = "${pkgs.ripgrep}/bin/rg";
      du = "${pkgs.du-dust}/bin/dust";
      ps = "${pkgs.procs}/bin/procs";
      m = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      ls = "${pkgs.exa}/bin/exa --icons --group-directories-first";
      la = "${pkgs.exa}/bin/exa -lah";
      tree = "${pkgs.exa}/bin/exa --tree --icons";
      http = "${pkgs.python3}/bin/python3 -m http.server";
      v = "nvim";
      ssh = "kitty +kitten ssh";
    };

    plugins = with pkgs inputs; [
      {
        name = "fzf-tab";
        src = pkgs.fzf-tab-src;
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
