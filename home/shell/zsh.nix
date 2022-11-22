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

      bindkey -v

      set -k
      setopt auto_cd
      setopt NO_NOMATCH
      setopt ALWAYS_TO_END
      setopt NO_CASE_GLOB
      setopt NO_LIST_BEEP
      setopt CORRECT
      SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

      # search history based on what's typed in the prompt
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # case insensitive tab completion
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*: matches' group yes
      zstyle ':completion:*: options' description yes
      zstyle ':completion:*: options' auto-description '%d'
      zstyle ':completion:*' verbose true
      _comp_options+=(globdots)

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

      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '

      export FZF_DEFAULT_OPTS='
      --color fg:#${theme.colors.fg},bg:#${theme.colors.dbg},hl:#${theme.colors.c4},fg+:#${theme.colors.c15},bg+:#${theme.colors.dbg},hl+:#${theme.colors.c4},border:#${theme.colors.c8}
      --color pointer:#${theme.colors.c9},info:#${theme.colors.lbg},spinner:#${theme.colors.lbg},header:#${theme.colors.lbg},prompt:#${theme.colors.c2},marker:#${theme.colors.c10}
      '

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

      zstyle ':completion:complete:*:options' sort false
      zstyle ':fzf-tab:complete:_zlua:*' query-string input

      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
    '';

    shellAliases = {
      rebuild = "sudo nix-store --verify; sudo nixos-rebuild --install-bootloader switch --flake .#; bat cache --build";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      nixtest = "sudo nixos-rebuild test --flake .#graphene --fast";
      bloat = "nix path-info -Sh /run/current-system";
      ytmp3 = ''
        ${pkgs.yt-dlp}/bin/yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
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
        name = "zsh-completions";
        src = inputs.zsh-completions;
      }
      {
        name = "fzf-tab";
        src = inputs.fzf-tab;
      }
      {
        name = "zsh-syntax-highlighting";
        src = inputs.zsh-syntax-highlighting;
        file = "zsh-syntax-highlighting.zsh";
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
