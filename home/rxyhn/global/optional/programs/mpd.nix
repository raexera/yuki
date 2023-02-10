{
  config,
  pkgs,
  ...
}: {
  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.xdg.userDirs.music}";
      extraConfig = ''
        auto_update           "yes"
        restore_paused        "yes"

        audio_output {
        	type                "pipewire"
        	name                "PipeWire Sound Server"
        	buffer_time         "100000"
        }

        audio_output {
        	type                "fifo"
        	name                "Visualizer"
        	format              "44100:16:2"
        	path                "/tmp/mpd.fifo"
        }

        audio_output {
        	type		            "httpd"
        	name		            "lossless"
        	encoder		          "flac"
        	port		            "8000"
        	max_client	        "8"
        	mixer_type	        "software"
        	format		          "44100:16:2"
        }
      '';
    };

    mpdris2 = {
      enable = true;
      mpd.host = "127.0.0.1";
    };
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };
    mpdMusicDir = "${config.xdg.userDirs.music}";
    settings = {
      ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "Visualizer";
      visualizer_in_stereo = "no";
      visualizer_type = "ellipse";
      visualizer_fps = "60";
      visualizer_look = "●▮";
      visualizer_color = "blue,39,33,93,165,201,magenta,white";
      alternative_header_first_line_format = "\"「 $b$5%a$8 - $6%t$0$/b 」\"";
      alternative_header_second_line_format = "%n. $5%b$0 [$6%y$0]";
      current_item_prefix = "\"$b$3»$5$i \"";
      current_item_suffix = "\" $/i$3«$0$/b\"";
      current_item_inactive_column_prefix = "\"$b$3»$/b$6 \"";
      current_item_inactive_column_suffix = "\"$0\"";
      now_playing_prefix = "\"$b$8 \"";
      now_playing_suffix = "\"$/b\"";
      song_window_title_format = "\"Now Playing: {%a - }{%t}|{%f}\"";
      song_columns_list_format = "(4f)[blue]{nr} (10f)[]{: } (30)[magenta]{b} (10)[blue]{ar} (40)[white]{t} (7f)[magenta]{lr:Length}";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      volume_change_step = "5";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      progressbar_look = "\"   \"";
      user_interface = "alternative";
      media_library_primary_tag = "album_artist";
      header_visibility = "no";
      statusbar_visibility = "no";
      connected_message_on_startup = "no";
      titles_visibility = "no";
      cyclic_scrolling = "yes";
      follow_now_playing_lyrics = "yes";
      screen_switcher_mode = "playlist, media_library, lyrics";
      startup_screen = "playlist";
      media_library_column_width_ratio_two = "1:2";
      media_library_column_width_ratio_three = "1:2:3";
      clock_display_seconds = "yes";
      display_bitrate = "yes";
      ignore_leading_the = "yes";
      ignore_diacritics = "yes";
      empty_tag_marker = "N/A";
      tag_editor_extended_numeration = "yes";
      tags_separator = "\", \"";
      external_editor = "nvim";
      colors_enabled = "yes";
      empty_tag_color = "cyan";
      header_window_color = "default";
      volume_color = "blue:b";
      state_flags_color = "blue:b";
      main_window_color = "white";
      color1 = "blue";
      color2 = "magenta";
      statusbar_time_color = "magenta:b";
      player_state_color = "magenta:b";
      alternative_ui_separator_color = "black:b";
      window_border_color = "green";
      active_window_border = "red";
    };
  };
}
