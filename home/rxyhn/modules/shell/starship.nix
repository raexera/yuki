{config, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      scan_timeout = 10;
      add_newline = true;
      line_break.disabled = false;
      cmd_duration.disabled = true;

      format = let
        git = "$git_branch$git_metrics$git_commit$git_state$git_status";
      in ''
        $directory${git}$all
      '';

      right_format = "$status";

      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
      };

      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
        style = "cyan";
        disabled = false;
      };

      status = {
        format = "[$symbol]($style)";
        symbol = "[](red)";
        success_symbol = "[](green)";
        disabled = false;
      };

      git_branch = {
        style = "purple";
        symbol = "";
      };

      git_metrics = {
        disabled = false;
        added_style = "bold yellow";
        deleted_style = "bold red";
      };

      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gcloud.symbol = " ";
      golang.symbol = " ";
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
