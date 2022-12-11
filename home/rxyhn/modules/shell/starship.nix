{config, ...}: let
  inherit (config.colorscheme) colors;
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      format = "$username$hostname$directory$git_branch$git_status$all";
      right_format = "$status";

      character = {
        success_symbol = "[](#${colors.base0C})";
        error_symbol = "[](#${colors.base0C})";
        vicmd_symbol = "[](bold green)";
      };

      username = {
        format = "[](fg:#${colors.base0C} bg:none)[ $user]($style)";
        style_user = "fg:#${colors.base00} bg:#${colors.base0C}";
        style_root = "fg:#${colors.base00} bg:#${colors.base0C}";
        show_always = true;
        disabled = false;
      };

      hostname = {
        format = "[@$hostname ]($style)[](fg:#${colors.base0C} bg:none) ";
        style = "fg:#${colors.base00} bg:#${colors.base0C}";
        ssh_only = false;
        disabled = false;
      };

      directory = {
        format = "[](fg:#${colors.base0C} bg:none)[ $path ]($style)[](fg:#${colors.base0C} bg:none) ";
        style = "fg:#${colors.base00} bg:#${colors.base0C}";
        truncation_length = 3;
        disabled = false;
      };

      status = {
        format = "[](fg:#${colors.base0C} bg:none)[ $symbol ]($style)[](fg:#${colors.base0C} bg:none)";
        symbol = "[]($style)";
        success_symbol = "[]($style)";
        style = "fg:#${colors.base00} bg:#${colors.base0C}";
        disabled = false;
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold red";
        symbol = " ";
        disabled = false;
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style)) ";
        style = "bold red";
        ahead = ">";
        behind = "<";
        diverged = "<>";
        up_to_date = "";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "r";
        deleted = "x";
        disabled = false;
      };

      cmd_duration.disabled = true;

      nix_shell.symbol = "[](blue) ";
      python.symbol = "[](blue) ";
      rust.symbol = "[](red) ";
      lua.symbol = "[](blue) ";
      package.symbol = "📦  ";
    };
  };
}
