{ config, pkgs, ... }: {
  home = {
    username = "flekgekei";
    homeDirectory = "/home/flekgekei";
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
    sessionPath = [ "/home/flekgekei/.local/bin" ];

    packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "Noto" ]; })
      fastfetch
      brightnessctl
    ];

    pointerCursor = {
      gtk.enable = true;
      size = 22;
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
    };

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };

    #sessionPath = [
    #  "$HOME/.local/bin"
    #];
  };
  
  imports = [
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/mako.nix
    ./modules/mpd.nix
    #./modules/ncmpcpp.nix
    #./modules/qt.nix
    ./modules/ranger.nix
    ./modules/waybar.nix
    #./modules/zsh.nix
  ];
}
