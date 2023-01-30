{config, ...}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      scan_timeout = 10;
      add_newline = true;
      line_break.disabled = false;

      format = "$directory$git_branch$git_metrics$all";
      right_format = "$status";

      directory.style = "cyan";
      git_branch.style = "purple";
      git_commit.tag_symbol = " tag ";

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vimcmd_symbol = "[λ](bold green)";
      };

      status = {
        format = "[$symbol]($style)";
        symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        disabled = false;
      };

      git_metrics = {
        disabled = false;
        added_style = "bold yellow";
        deleted_style = "bold red";
      };

      aws.symbol = "aws ";
      bun.symbol = "bun ";
      c.symbol = "C ";
      cobol.symbol = "cobol ";
      conda.symbol = "conda ";
      crystal.symbol = "cr ";
      cmake.symbol = "cmake ";
      daml.symbol = "daml ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      dotnet.symbol = ".NET ";
      directory.read_only = " ro";
      docker_context.symbol = "docker ";
      elixir.symbol = "exs ";
      elm.symbol = "elm ";
      git_branch.symbol = "git ";
      golang.symbol = "go ";
      guix_shell.symbol = "guix ";
      hg_branch.symbol = "hg ";
      java.symbol = "java ";
      julia.symbol = "jl ";
      kotlin.symbol = "kt ";
      lua.symbol = "lua ";
      memory_usage.symbol = "memory ";
      meson.symbol = "meson ";
      nim.symbol = "nim ";
      nix_shell.symbol = "nix ";
      ocaml.symbol = "ml ";
      opa.symbol = "opa ";
      nodejs.symbol = "nodejs ";
      package.symbol = "pkg ";
      perl.symbol = "pl ";
      php.symbol = "php ";
      pulumi.symbol = "pulumi ";
      purescript.symbol = "purs ";
      python.symbol = "py ";
      raku.symbol = "raku ";
      ruby.symbol = "rb ";
      rust.symbol = "rs ";
      scala.symbol = "scala ";
      spack.symbol = "spack ";
      sudo.symbol = "sudo ";
      swift.symbol = "swift ";
      terraform.symbol = "terraform ";
      zig.symbol = "zig ";
    };
  };
}
