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
      efi.canTouchEfiVariables = false;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "i915" ];
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
	Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "fgk";
    networkmanager.enable = true;
  };

  time.timeZone = "CET";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "ru_RU.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    wrappers = {
      intel_gpu_top = {
	owner = "root";
	group = "root";
	capabilities = "cap_perfmon+ep";
	source = "${pkgs.intel-gpu-tools.out}/bin/intel_gpu_top";
      };
    };
  };

  sound.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    logind.lidSwitch = "ignore";
    udisks2.enable = true;
    #illum.enable = true;
    #asusd = {
    #  enable = true;
    #};
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      flekgekei = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "imput" "networkmanager" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    #cli-shit
    wget
    curl
    ranger
    htop
    fzf
    zip
    unzip
    p7zip
    mpc-cli
    swww
    wl-clipboard
    cliphist
    steamcmd
    ##books
    texliveFull
    #other
    mpd
    home-manager
    intel-graphics-compiler
    intel-compute-runtime
    intel-gpu-tools
    mesa
    mesa-demos
    mako
    bc
    jq
    speedcrunch
    ## for hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    xdg-utils
    udiskie
    #ui
    kitty
    vivaldi
    webcord
    vlc
    bemenu
    telegram-desktop
    qbittorrent
    megasync
    waybar
    pavucontrol
    onedrive
    imv
    wf-recorder
    grim
    slurp
    gimp
    evince
    texstudio
    ##games
    prismlauncher
    osu-lazer-bin
    ##gtk&other
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze
    qt6Packages.qt6gtk2
    #compat
    wineWowPackages.full
    winetricks
  ];

  programs = { 
    nixvim = {
      enable = true;
      defaultEditor = true;
      extraPlugins = with pkgs.vimPlugins; [
        vim-airline
	nerdtree
	vim-surround
	vim-css-color
	vim-devicons
	vim-multiple-cursors
	iceberg-vim
	nerdcommenter
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
    gnupg = {
      agent = {
	enable = true;
	enableSSHSupport = true;
      };
    };
    hyprland.enable = true;
    gamemode.enable = true;
    git.enable = true;
  };
  
  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "gtk2";
  };

  fonts.packages = with pkgs; [
   noto-fonts
   noto-fonts-lgc-plus
   noto-fonts-cjk-sans
   noto-fonts-cjk-serif
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
	pkgs.xdg-desktop-portal-hyprland
      ];
    };
    mime = {
      enable = true;
      #addedAssociations = {
      #  "application/pdf" = "org.gnome.Evince.desktop";
      #};
      #defaultApplications = {
      #  "" = "";
      #};
    };
  };

  # Open ports in the firewall. 
  networking = {
    nftables.enable = true;
    firewall = {
      allowedTCPPorts = [
	6600
      ];
      allowedUDPPorts = [
	6600
      ];
    };
  };

  system.stateVersion = "23.11"; 
}
