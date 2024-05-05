{
  programs.ncmpcpp = {
    mpdMusicDir = "/home/flekgekei/Music";
    settings = {
      ncmpcpp_directory = "/home/flekgekei/.config/ncmpcpp";

      mpd_host = "localhost";
      mpd_port = "6600";
      mpd_connection_timeout = "5";
      mpd_crossfade_time = "5";

      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "Fifo";
      visualizer_in_stereo = "yes";
      visualizer_sync_interval = "0";
      visualizer_type = "spectrum";
      visualizer_fps = "60";
      visualizer_autoscale = "no";
      visualizer_look = "●▮";
      visualizer_color = "256";
      visualizer_spectrum_smooth_look = "yes";
      visualizer_spectrum_dft_size = "2";
      visualizer_spectrum_gain = "10";
      visualizer_spectrum_hz_min = "20";
      visualizer_spectrum_hz_max = "20000";

      system_encoding = "UTF-8";

      playlist_disable_highlight_delay = "5";

      message_delay_time = "5";

      song_list_format = "{%a - }{%t}|{$8%f$9}$R{$3%l$9}";
      song_status_format = "{{%a{ %b{ (%y)}} - }{%t}}|{%f}";
      song_library_format = "{%n - }{%t}|{%f}";

      alternative_header_first_line_format = "$b$1$aqqu$/a$9 {%t}|{%f} $1$atqq$/a$9$/b";
      alternative_header_second_line_format = "{{$4$b%a$/b$9}{ - $7%b$9}{ ($4%y$9)}}|{%D}";

      current_item_prefix = "$(yellow)$r";
      current_item_suffix = "$/r$(end)";
      current_item_inactive_column_prefix = "$(white)$r";
      current_item_inactive_column_suffix = "$/r$(end)";

      now_playing_prefix = "$b";
      now_playing_suffix = "$/b";

      selected_item_prefix = "$6";
      selected_item_suffix = "$9";

      modified_item_prefix = "$3> $9";

      song_window_title_format = "{%a - }{%t}|{%f}";

      browser_sort_mode = "type";
      browser_sort_format = "{%a - }{%t}|{%f} {%l}";
      browser_display_mode = "classic";
      browser_playlist_prefix = "$2playlist$9 ";

      song_columns_list_format = "(20)[]{a} (6f)[green]{NE} (50)[white]{t|f:Title} (20)[cyan]{b} (7f)[magenta]{l}";

      execute_on_song_change = "";
      execute_on_player_state_change = "";

      playlist_show_mpd_host = "no";
      playlist_show_remaining_time = "no";
      playlist_shorten_total_times = "no";
      playlist_separate_albums = "no";
      playlist_display_mode = "columns";
      playlist_editor_display_mode = "classic";

      search_engine_display_mode = "classic";

      discard_colors_if_item_is_selected = "yes";

      show_duplicate_tags = "yes";

      incremental_seeking = "yes";

      seek_time = "1";

      volume_change_step = "2";

      autocenter_mode = "no";

      centered_cursor = "no";

      progressbar_look = "▊▊▊";

      default_place_to_search_in = "database";

      user_interface = "classic";

      data_fetching_delay = "yes";

      media_library_primary_tag = "artist";

      media_library_albums_split_by_date = "yes";

      media_library_hide_album_dates = "no";

      default_find_mode = "wrapped";
      default_tag_editor_pattern = "%n - %t";

      header_visibility = "yes";

      statusbar_visibility = "yes";

      titles_visibility = "yes";

      header_text_scrolling = "yes";

      cyclic_scrolling = "no";

      lyrics_fetchers = "azlyrics, genius, musixmatch, sing365, metrolyrics, justsomelyrics, jahlyrics, plyrics, tekstowo, zeneszoveg, internet";

      follow_now_playing_lyrics = "no";

      fetch_lyrics_for_current_song_in_background = "no";

      store_lyrics_in_song_dir = "no";

      allow_for_physical_item_deletion = "no";

      space_add_mode = "add_remove";

      show_hidden_files_in_local_browser = "no";

      startup_screen = "playlist";

      locked_screen_width_part = "50";

      ask_for_locked_screen_width_part = "yes";

      jump_to_now_playing_song_at_start = "yes";

      ask_before_clearing_playlists = "yes";

      clock_display_seconds = "no";

      display_volume_level = "yes";
      display_bitrate = "no";
      display_remaining_time = "no";

      regular_expressions = "perl";

      ignore_leading_the = "no";

      ignore_diacritics = "no";

      block_search_constraints_change_if_items_found = "yes";

      mouse_support = "yes";

      mouse_list_scroll_whole_page = "no";

      lines_scrolled = "5";

      empty_tag_marker = "<empty>";

      tags_separator = " | ";

      tag_editor_extended_numeration = "no";

      media_library_sort_by_mtime = "no";

      enable_window_title = "yes";

      search_engine_default_search_mode = "1";

      external_editor = "nvim";

      use_console_editor = "yes";

      colors_enabled = "yes";

      empty_tag_color = "cyan";

      header_window_color = "default";

      volume_color = "default";

      state_line_color = "default";

      state_flags_color = "default:b";

      main_window_color = "yellow";

      color1 = "white";

      color2 = "green";

      progressbar_color = "black:b";
      progressbar_elapsed_color = "white:b";

      statusbar_color = "default";
      statusbar_time_color = "default:b";

      player_state_color = "default:b";

      alternative_ui_separator_color = "black:b";

      window_border_color = "green";

      active_window_border = "red";
    };
  };
}
