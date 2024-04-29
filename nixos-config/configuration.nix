{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  nix = { 
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
   };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware = {
    opengl.driSupport32Bit = true;
  };

  networking = {
    hostName = "fgk";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "CET";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "ru_RU.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      flekgekei = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "imput" "networkmanager" ]; # Enable ‘sudo’ for the user.
      };
    };
  };

  environment.systemPackages = with pkgs; [
    #cli-shit
    wget
    git
    curl
    ranger
    htop
    ncmpcpp
    fzf
    zip
    unzip
    p7zip
    mpc-cli
    swww
    wl-clipboard
    ##books
    texliveFull
    #other
    mpd
    home-manager
    intel-graphics-compiler
    intel-compute-runtime
    mako
    #ui
    kitty
    vivaldi
    discord
    vlc
    bemenu
    telegram-desktop
    qbittorrent
    megasync
    waybar
    pavucontrol
    onedrive
    ##games
    prismlauncher
    osu-lazer-bin
    ##gtk&other
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze
    noto-fonts
    #compat
    wineWowPackages.full
    winetricks
  ];

  programs = { 
    nixvim = {
      enable = true;
      defaultEditor = true;
      extraPlugins = [
        pkgs.vimPlugins.vim-airline
	pkgs.vimPlugins.nerdtree
	pkgs.vimPlugins.vim-surround
	pkgs.vimPlugins.vim-css-color
	pkgs.vimPlugins.vim-devicons
	pkgs.vimPlugins.vim-multiple-cursors
	pkgs.vimPlugins.iceberg-vim
	pkgs.vimPlugins.nerdcommenter
      ];
      colorscheme = "iceberg";
      opts = {
        number = true;
	relativenumber = true;
	shiftwidth = 2;
	mouse = "a";
      };
      clipboard = {
        register = "unnamedplus";
	providers.wl-copy.enable = true;
      };
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
	theme = "agnoster";
	plugins = [
          "git"
	  "sudo"
	  "fzf"
	  "zsh-interactive-cd"
	  "extract"
	];
      };
    };
    hyprland.enable = true;
    gamemode = {
      enable = true;
    };
  };

  # Open ports in the firewall.
  networking.nftables = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}

