# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader.
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };
  };

  console.keyMap = "jp106";

  environment = {
    localBinInPath = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      bitwarden-desktop
      docker-buildx
      docker-compose
      emacs
      fastfetch
      feh
      file
      google-chrome
      openssl
      p7zip
      ripgrep
      sbcl
      unzip
      vscode
      wget
      wezterm
      xsel
      zip
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans CJK JP" ];
        monospace = [ "HackGen" ];
      };
    };

    packages = with pkgs; [
      font-awesome
      hackgen-font
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      roboto
    ];
  };

  hardware.graphics.enable32Bit = true;

  i18n = {
    # Select internationalisation properties.
    defaultLocale = "ja_JP.UTF-8";

    inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        addons = with pkgs; [
          fcitx5-skk
          fcitx5-gtk
          libsForQt5.fcitx5-qt
        ];
      };
    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    useNetworkd = true;
    firewall.enable = false;
  };

  nix = {
    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      # Optimize storage
      # You can also manually optimize the store via:
      #    nix-store --optimise
      # Refer to the following link for more details:
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    bash = {
      shellAliases = import ./home/bash-aliases.nix;
      shellInit = builtins.readFile ./etc/bash-shellInit.sh;
    };

    git = {
      enable = true;
      lfs.enable = true;

      config = {
        core.quotePath = false;
      };
    };

    nano.enable = false;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    tmux = import ./home/.config/tmux/tmux.nix;
  };

  security.polkit.enable = true;

  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = import ./etc/sshd/sshd.nix;
    };

    resolved.enable = true;

    xserver = {
      enable = true;
      displayManager = {
        lightdm = {
          extraSeatDefaults = "greeter-hide-users = true";
          greeters.gtk.clock-format = "%Y/%m/%d %H:%M";
        };
        session = [
          { manage = "window";
            name = "stumpwm";
            start = "/home/satoshi/startstump";
          }
        ];
      };

      # Configure keymap in X11
      xkb = {
        layout = "jp";
        model = "jp106";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  systemd.network.networks."20-wired" = import ./etc/systemd/network/20-wired.nix;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.satoshi = {
      group = "satoshi";
      extraGroups = [ "wheel" "docker" ];
      isNormalUser = true;
      hashedPassword = "$y$j9T$i8FidX3eyTOwJ8sRB9Zlv/$AUbG0y.3CcB2Mdj3zd3DQSo/Q7WnqG3y84MJeAqG0x4";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5UERJFt3NpoGmdv3mhTkJiw4BaCJRIZ6akRoLr2BDH noppi"
      ];
      packages = with pkgs; [];
    };

    groups.satoshi = {
      gid = 1000;
    };
  };

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
  };
}
