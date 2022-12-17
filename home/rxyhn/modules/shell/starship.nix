{config, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      format = let
        git = "$git_branch$git_commit$git_state$git_status";
      in ''
        $directory(${git})$all
      '';

      right_format = "$status";

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vicmd_symbol = "[](bold green)";
      };

      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
        disabled = false;
      };

      status = {
        format = "[$symbol]($style)";
        symbol = "[](bold red)";
        success_symbol = "[](bold green)";
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

      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gcloud.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = " ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = "ﯣ ";
      terraform.symbol = "行 ";
    };
  };
}
