{pkgs, ...}:
{
  programs.lf = {
    enable = true;
    settings = {
      icons = true;
    };
    previewer = {
      source = pkgs.writeShellScript "pv.sh" ''
	#!/bin/sh

	case "$1" in
	  *.tar*) tar tf "$1";;
	  *.zip) unzip -l "$1";;
	  *.rar) unrar l "$1";;
	  *.7z) 7z l "$1";;
	  *.pdf) pdftotext "$1" -;;
	  *) highlight -O ansi "$1" || cat "$1";;
	esac
      '';
      keybinding = "i";
    };
    extraConfig = ''
      set previewer ${pkgs.ctpv}/bin/ctpv
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
      &${pkgs.ctpv}/bin/ctpv -s $id
      &${pkgs.ctpv}/bin/ctpvquit $id

      set hidden true 

      cmd fzf_search ''${{
        res="$( \
          RG_PREFIX="${pkgs.ripgrep}/bin/rg --column --line-number --no-heading --color=always \
            --smart-case "
          FZF_DEFAULT_COMMAND="$RG_PREFIX '''" \
            ${pkgs.fzf}/bin/fzf --bind "change:reload:$RG_PREFIX {q} || true" \
            --ansi --layout=reverse --header 'Search in files' \
            | cut -d':' -f1
        )"
        [ ! -z "$res" ] && lf -remote "send $id select \"$res\""
      }}
    '';
  };
  home = {
    packages = with pkgs; [ ctpv ripgrep ];
    file = {
      colors = {
	source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
	target = ".config/lf/colors";
      };
      icons = {
	source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
	target = ".config/lf/icons";
      };
    };
  };
}
