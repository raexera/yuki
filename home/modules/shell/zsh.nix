{
  config,
  lib,
  ...
}: {
  programs = {
    btop.enable = true;
    eza.enable = true;
    ssh.enable = true;

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        style = "plain";
        theme = "base16";
      };
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      dirHashes = {
        downloads = "$HOME/Downloads";
        Documents = "$HOME/Documents";
        code = "$HOME/Documents/code";
        dotfiles = "$HOME/Documents/code/dotfiles";
        pictures = "$HOME/Pictures";
        videos = "$HOME/Videos";
      };
      dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        path = "${config.xdg.dataHome}/zsh_history";
      };

      initExtra = ''
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end

        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true

        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        _comp_options+=(globdots)

        ${lib.optionalString config.services.gpg-agent.enable ''
          gnupg_path=$(ls $XDG_RUNTIME_DIR/gnupg)
          export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
        ''}
      '';

      shellAliases = {
        cat = "bat";
        grep = "ripgrep";
        fzf = "skim";
        untar = "tar -xvf";
        untargz = "tar -xzf";
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        du = "du-dust";
        ps = "procs";
        la = "eza -lah --tree";
        ls = "eza -h --git --icons --color=auto --group-directories-first -s extension";
        tree = "eza --tree --icons --tree";
      };
      shellGlobalAliases = {eza = "eza --icons --git";};
    };
  };
}
