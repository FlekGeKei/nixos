{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/flekgekei/Music";
    playlistDirectory = "/home/flekgekei/.config/mpd/playlists";
    dataDir = "/home/flekgekei/.config/mpd";
    dbFile = "/home/flekgekei/.config/mpd/mpd.db";
    network = {
      listenAddress = "any";
      port = 6600;
      startWhenNeeded = false;
    };
    extraConfig = ''
      audio_output {
	type			"pipewire"
	name			"Pipewire Sound Server"
      }
      ## Визуализация
      audio_output {
	type			"fifo"
	name			"Fifo"
        path			"/tmp/mpd.fifo"
        format			"44100:16:2"
      }
      input {
	plugin			"curl"
      }
    '';
  };
}
