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
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "electron-28.3.3" ];
    };
#    overlays = [
#      (self: super: {
#	nixos-upgrade = pkgs.writeScriptBin "nixos-upgrade" ''
#	  homies=("flekgekei" "idk")
#	  for element in ${homies[@]}; do
#	    if [[ $USER == $element ]] 
#	      then
#		sudo nix flake update /etc/nixos
#		sudo nixos-rebuile switch --flake /etc/nixos
#		home-manager switch
#	      elif [[ $USER == root ]]; then
#		nix flake update /etc/nixos
#		nixos-rebuild switch --flake /etc/nixos
#		echo ""
#		echo "don't forget to update home configuration"
#	      else
#		echo "get out"
#	    fi
#	  done
#	'';
#      })
#    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 2*1024;
    }
  ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
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
    graphics = {
      enable = true;
      enable32Bit = true;
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
    unrar
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
    intel-gpu-tools
    mesa-demos
    mako
    bc
    jq
    speedcrunch
    arrpc
    home-manager
    ## for hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    xdg-utils
    udiskie
    #ui
    kitty
    vivaldi
    vivaldi-ffmpeg-codecs
    vesktop
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
    blockbench
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
    # nur
    nur.repos.ataraxiasjel.waydroid-script
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
	vim-visual-multi
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
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    zsh = {
      enable = true;
      shellInit = ''
	export PATH="$PATH:$HOME/.local/bin"
      '';
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
    git = {
      enable = true;
      lfs.enable = true;
    };
    hyprland.enable = true;
    gamemode.enable = true;
  };

  virtualisation.waydroid.enable = true;
  
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
	25565
      ];
      allowedUDPPorts = [
	6600
	24454
      ];
    };
  };

  system.stateVersion = "23.11"; 
}
