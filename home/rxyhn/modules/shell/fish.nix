{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';
    shellInit = ''
      # Disable fish greeting
      set -g fish_greeting

      # Set fish vi key bindings
      fish_vi_key_bindings

      # Language Default
      set -gx LC_ALL en_US.UTF-8
      set -gx LC_CTYPE en_US.UTF-8

      # Colorschemes
      set fish_color_normal cdd6f4
      set fish_color_command 89b4fa
      set fish_color_param f2cdcd
      set fish_color_keyword f38ba8
      set fish_color_quote a6e3a1
      set fish_color_redirection f5c2e7
      set fish_color_end fab387
      set fish_color_comment 7f849c
      set fish_color_error f38ba8
      set fish_color_gray 6c7086
      set fish_color_selection --background=313244
      set fish_color_search_match --background=313244
      set fish_color_operator f5c2e7
      set fish_color_escape eba0ac
      set fish_color_autosuggestion 6c7086
      set fish_color_cancel f38ba8
      set fish_color_cwd f9e2af
      set fish_color_user 94e2d5
      set fish_color_host 89b4fa
      set fish_color_host_remote a6e3a1
      set fish_color_status f38ba8
      set fish_pager_color_progress 6c7086
      set fish_pager_color_prefix f5c2e7
      set fish_pager_color_completion cdd6f4
      set fish_pager_color_description 6c7086

      set -Ux FZF_DEFAULT_OPTS "\
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      # Sudo prompt
      set -gx SUDO_PROMPT (set_color blue)"[sudo]"(set_color normal)" password for %u: "(echo -e '\a')
    '';
    shellAbbrs = {
      g = "git";
      ga = "git add";
      gam = "git am";
      gap = "git apply";
      gb = "git branch";
      gbs = "git bisect";
      gc = "git commit";
      gcl = "git clone";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gd = "git diff";
      gf = "git fetch";
      gl = "git log";
      gm = "git merge";
      gp = "git push";
      gpl = "git pull";
      gr = "git remote";
      grb = "git rebase";
      grev = "git revert";
      grh = "git reset";
      grm = "git rm";
      grs = "git restore";
      gsh = "git show";
      gst = "git status";
      gsw = "git switch";
    };
    shellAliases = {
      commit = "git add . && git commit -m";
      push = "git push";
      pull = "git pull";
      rebuild = "sudo nix-store --verify; pushd ~dotfiles && sudo nixos-rebuild switch --flake .# && notify-send \"Done\" && bat cache --build; popd";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      cat = "${pkgs.bat}/bin/bat --style=plain";
      grep = "${pkgs.ripgrep}/bin/rg";
      du = "${pkgs.du-dust}/bin/dust";
      ps = "${pkgs.procs}/bin/procs";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      m = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      ls = "${pkgs.exa}/bin/exa --icons --group-directories-first";
      la = "${pkgs.exa}/bin/exa -lah";
      tree = "${pkgs.exa}/bin/exa --tree --icons";
      http = "${pkgs.python3}/bin/python3 -m http.server";
      v = "hx";
      nvim = "hx";
      vim = "hx";
    };
    functions = {
      run = {
        description = "Run nixpkgs";
        body = ''
          nix run nixpkgs#$argv[1]
        '';
      };
      git-svn = {
        description = "Download subfolder in git repository";
        body = ''
          set repository $argv[1]
          set subfolder $argv[2]
          if test -n $repository && test -n $subfolder
              echo "Starting clone/copy ..."
              set repo (echo $repository | sed 's/\/$\|.git$//')
              svn export "$repo/trunk/$subfolder"
          else
              echo "Use: git-svn <repository> <subdirectory>"
          end
        '';
      };
      extract = {
        description = "Expand or extract bundled & compressed files";
        body = ''
          for file in $argv
            if test -f $file
              echo -s "Extracting " (set_color --bold blue) $file (set_color normal)
              switch $file
                case "*.tar"
                  tar -xvf $file
                case "*.tar.bz2" "*.tbz2"
                  tar --bzip2 -xvf $file
                case "*.tar.gz" "*.tgz"
                  tar --gzip -xvf $file
                case "*.bz" "*.bz2"
                  bunzip2 $file
                case "*.gz"
                  gunzip $file
                case "*.rar"
                  unrar x $file
                case "*.zip"
                  unzip -uo $file -d (basename $file .zip)
                case "*.Z"
                  uncompress $file
                case "*.pax"
                  pax -r < $file
                case "*.7z"
                  7z x $file -o(basename $file .7z)
                case '*'
                  echo "Extension not recognized, cannot extract $file"
              end
            else
              echo "$file is not a valid file"
            end
          end
        '';
      };
      ytmp3 = {
        description = "Download youtube video using yt-dlp and convert it to mp3";
        body = ''
          ${pkgs.yt-dlp}/bin/yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s" $argv[1]
        '';
      };
    };
    plugins = [
      {
        name = "nix-env.fish";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "ff3e9c5e31b46e1a7f70a0114af4b2a68e1b9bc3";
          sha256 = "sha256-uykuDA8G+n9IJjt2FS9fCaUMx0ubWlTR//A+TpVMM/k=";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "2e8a24614bb9c3d0914553c95451334830518c6f";
          sha256 = "sha256-XsxGUK+KHfGIbcmedKeY7zQpmt1ZwyBxR26DkCIKRrY=";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
          sha256 = "sha256-6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
        };
      }
      {
        name = "sponge";
        src = pkgs.fetchFromGitHub {
          owner = "meaningful-ooo";
          repo = "sponge";
          rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
          sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
        };
      }
      {
        name = "forgit";
        src = pkgs.fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "be8c306c18754f6ede2955f901b832a3225d4b83";
          sha256 = "sha256-2uuYNh3byk6yrMB3+7dvea+LgDZuAdvrpiPPlCTDlFI=";
        };
      }
    ];
  };
}
