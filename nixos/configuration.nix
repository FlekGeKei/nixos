{ config, pkgs, meta, ... }: 

{
  imports = [ 
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

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 2*1024;
  }];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "i915" ];
  };

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
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
    networkmanager = {
      enable = true;
      ensureProfiles = {
	environmentFiles = [ config.sops.templates."networks.env".path ];
	profiles = {
	  N1 = {
	    connection = {
	      id = "$N1_NAME2";
	      type = "wifi";
	      interface-name = "${meta.wifiModule}";
	    };
	    wifi = {
	      mode = "infrastructure";
	      ssid = "$N1_NAME2";
	    };
	    wifi-security = {
	      auth-alg = "open";
	      key-mgmt = "wpa-psk";
	      psk = "$N1_PASS";
	    };
	    ipv4 = { method = "auto"; };
	    ipv6 = {
	      addr-gen-mode = "default";
	      method = "auto";
	    };
	    proxy = { };
	  };
	  "N1-2" = {
	    connection = {
	      id = "$N1_NAME";
	      type = "wifi";
	      interface-name = "${meta.wifiModule}";
	    };
	    wifi = {
	      mode = "infrastructure";
	      ssid = "$N1_NAME";
	    };
	    wifi-security = {
	      auth-alg = "open";
	      key-mgmt = "wpa-psk";
	      psk = "$N1_PASS";
	    };
	    ipv4 = { method = "auto"; };
	    ipv6 = {
	      addr-gen-mode = "default";
	      method = "auto";
	    };
	    proxy = { };
	  };
	  N2 = {
	    connection = {
	      id = "$N2_NAME";
	      type = "wifi";
	      interface-name = "${meta.wifiModule}";
	    };
	    wifi = {
	      mode = "infrastructure";
	      ssid = "$N2_NAME";
	    };
	    wifi-security = {
	      auth-alg = "open";
	      key-mgmt = "wpa-psk";
	      psk = "$N2_PASS";
	    };
	    ipv4 = { method = "auto"; };
	    ipv6 = {
	      addr-gen-mode = "default";
	      method = "auto";
	    };
	    proxy = { };
	  };
	  N3 = {
	    connection = {
	      id = "$N3_NAME";
	      type = "wifi";
	      interface-name = "${meta.wifiModule}";
	    };
	    wifi = {
	      mode = "infrastructure";
	      ssid = "$N3_NAME";
	    };
	    wifi-security = {
	      auth-alg = "open";
	      key-mgmt = "wpa-psk";
	      psk = "$N3_PASS";
	    };
	    ipv4 = { method = "auto"; };
	    ipv6 = {
	      addr-gen-mode = "default";
	      method = "auto";
	    };
	    proxy = { };
	  };
	};
      };
    };
    hostName = meta.hostname;
    nftables.enable = true;
    firewall = {
      allowedTCPPorts = [
	6600
	25565
      ];
      allowedUDPPorts = [
	6600
      ];
    };
  };

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

  sops = {
    age = {
      keyFile = "/home/${meta.adminUser}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/root/.ssh/id_ed25519" ];
    };

    defaultSopsFormat = "yaml";
    defaultSopsFile = ./secrets/secrets.yaml;

    secrets = {
      "users/flekgekei/passwordHashed".neededForUsers = true;
      "users/root/passwordHashed".neededForUsers = true;
      "networking/networkmanager/profiles/N1/name" = {};
      "networking/networkmanager/profiles/N1/name2" = {};
      "networking/networkmanager/profiles/N1/password" = {};
      "networking/networkmanager/profiles/N2/name" = {};
      "networking/networkmanager/profiles/N2/password" = {};
      "networking/networkmanager/profiles/N3/name" = {};
      "networking/networkmanager/profiles/N3/password" = {};
    };

    templates = {
      "networks.env" = {
	content = ''
	  N1_NAME="${config.sops.placeholder."networking/networkmanager/profiles/N1/name"}"
	  N1_NAME2="${config.sops.placeholder."networking/networkmanager/profiles/N1/name2"}"
	  N1_PASS="${config.sops.placeholder."networking/networkmanager/profiles/N1/password"}"
	  N2_NAME="${config.sops.placeholder."networking/networkmanager/profiles/N2/name"}"
	  N2_PASS="${config.sops.placeholder."networking/networkmanager/profiles/N2/password"}"
	  N3_NAME="${config.sops.placeholder."networking/networkmanager/profiles/N3/name"}"
	  N3_PATH="${config.sops.placeholder."networking/networkmanager/profiles/N3/password"}"
	'';
	path = "/run/secrets/networks.env";
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
      audio.enable = true;
      wireplumber.enable = true;
    };
    syncthing = {
      #settings = {
	#folders = {
	#};
      #};
      enable = true;
      user = meta.adminUser;
      group = "users";
      openDefaultPorts = true;
    };
    clamav = {
      scanner.enable = true;
      updater.enable = true;
      daemon.enable = true;
    };
    fail2ban.enable = false;
    logind.lidSwitch = "ignore";
    udisks2.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
    illum.enable = false;
    asusd.enable = false;
  };

  users = {
    users = {
      ${meta.adminUser} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "imput" "networkmanager" ];
	hashedPasswordFile = config.sops.secrets."users/flekgekei/passwordHashed".path;
      };
      root.hashedPasswordFile = config.sops.secrets."users/root/passwordHashed".path;
    };
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
  };

  environment.systemPackages = with pkgs; [
    #cli-shit
    wget
    curl
    ranger
    fzf
    zip
    unzip
    unrar
    p7zip
    mpc-cli
    wl-clipboard
    cliphist
    ##books
    texliveFull
    #other
    mpd
    intel-gpu-tools
    intel-compute-runtime
    intel-graphics-compiler
    mesa-demos
    mako
    bc
    jq
    speedcrunch
    home-manager
    megacmd
    coppwr
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
    waybar
    pwvucontrol
    imv
    wf-recorder
    grim
    slurp
    gimp
    evince
    texstudio
    kdePackages.filelight
    keepassxc
    clamtk
    libreoffice
    thunderbird
    ##games
    prismlauncher
    osu-lazer-bin
    heroic
    ##gtk&other
    hyprcursor
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
    #nur.repos.ataraxiasjel.waydroid-script
    #sops
    age
    sops
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
      plugins = {
	lsp = {
	  enable = true;
	  servers = {
	    ts_ls.enable = true;
	    lua_ls.enable = true;
	    pylsp.enable = true;
	    bashls.enable = true;
	    nil_ls.enable = true;
	  };
	};
	cmp = {
	  enable = true;
	  autoEnableSources = true;
	  settings.sources = [
	    { name = "nvim_lsp"; }
	    { name = "path"; }
	    { name = "buffer"; }
	  ];
	  settings.mapping = {
	    "<C-Space>" = "cmp.mapping.complete()";
	    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
	    "<C-e>" = "cmp.mapping.close()";
	    "<C-f>" = "cmp.mapping.scroll_docs(4)";
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
	    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	  };
	};
      };
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
      colorscheme = "iceberg";
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      extraCompatPackages = with pkgs; [
	proton-ge-bin
      ];
    };
    zsh = {
      enable = true;
      shellInit = ''
	export PATH="$PATH:$HOME/.local/bin"

	source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
	zstyle ':completion:*:git-checkout:*' sort false
	zstyle ':completion:*:descriptions' format '[%d]'
	zstyle ':completion:*' menu no
	zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.eza}/bin/eza -1 --color=always $realpath'
	zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
	zstyle ':fzf-tab:*' use-fzf-default-opts yes
	zstyle ':fzf-tab:*' switch-group '<' '>'
	zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
      '';
      ohMyZsh = {
        enable = true;
	theme = "agnoster";
	plugins = [
          "git"
	  "sudo"
	  "extract"
	  "man"
	];
	customPkgs = with pkgs; [
	  zsh-fzf-tab
	  eza
	];
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
    htop = {
      enable = true;
      settings = {
	show_cpu_frequency = true;
	show_cpu_temperature = true;
      };
    };
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    firefox.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    tmux.enable = true;
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
	"image/png" = "imv.desktop"; 
	"image/jpeg" = "imv.desktop"; 
	"image/svg" = "imv.desktop"; 
	"image/gif" = "imv.desktop"; 
	"image/tiff" = "imv.desktop"; 
	"image/webp" = "imv.desktop"; 
      };
    };
  };

  time.timeZone = "CET";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; 
}
