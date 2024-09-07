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
      "vm.max_map_count" = 2147483642;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
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
    bluetooth = {
      enable = true;
      settings = {
	General = {
	  Experimental = true;
	};
      };
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
    doas.enable = true;
    sudo.enable = false;
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
    flatpak.enable = true;
    blueman.enable = true;
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
    wl-clipboard
    cliphist
    steamcmd
    gamescope
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
    udiskie
    brightnessctl
    #ui
    kitty
    vesktop
    vlc
    bemenu
    telegram-desktop
    qbittorrent
    megacmd
    waybar
    pwvucontrol
    onedrive
    imv
    wf-recorder
    grim
    slurp
    gimp
    evince
    texstudio
    kdePackages.filelight
    ##games
    prismlauncher
    osu-lazer-bin
    heroic
    ##gtk&other
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze
    qt6Packages.qt6gtk2
    qt6.qtwayland
    qt5.qtwayland
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
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      extraPackages = with pkgs; [
	steamcmd
	gamescope
      ];
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
    firefox.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
  };

  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "gtk2";
  };

  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "Noto" ]; })
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
  ];

  xdg = {
    portal.enable = true;
    mime = {
      enable = true;
      addedAssociations = {
        "application/pdf" = "org.gnome.Evince.desktop";
      };
      defaultApplications = {
        "application/pdf" = "org.gnome.Evince.desktop";
      };
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
