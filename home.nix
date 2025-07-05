{ config, pkgs, ... }:

{
  home.username = "satoshi";
  home.homeDirectory = "/home/satoshi";

  # link the configuration file in current directory to the specified location in
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
  home.file.".emacs.d/init.el".source = ./home/satoshi/.emacs.d/init.el;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
  ];

  # basic configuration of git, please change to your own
  programs = {
    git = {
      enable = true;
      userName = "Noppi";
      userEmail = "noppi@noppi.jp";
      extraConfig = {
        push.default = "nothing";
      };
    };

    neovim = {
      enable = true;
      extraConfig = ''
        colorscheme vim
        set expandtab
        set ignorecase
        set number
        set shiftwidth=0
        set showmatch
        set smartcase
        set smartindent
        set tabstop=4
        set termguicolors

        set ambiwidth=double
        set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,euc-jp,cp932,utf-16le,default,laten1
      '';
    };

    waybar = {
      enable = true;

      settings.main = {
        height = 30;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "clock" "tray" ];

        # Modules configuration
        "hyprland/workspaces".persistent-workspaces = { "*" = 10; };
        clock = {
          format = "{:%Y/%m/%d %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };
        tray.spacing = 10;
      };

      style = ''
        * {
           /* `otf-font-awesome` is required to be installed for icons */
           font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
           font-size: 13px;
        }

        window#waybar {
            background-color: rgba(43, 48, 59, 0.5);
            border-bottom: 3px solid rgba(100, 114, 125, 0.5);
            color: #ffffff;
            transition-property: background-color;
            transition-duration: .5s;
        }

        window#waybar.hidden { opacity: 0.2; }

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-button-have-a-strange-hover-effect */
        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px #ffffff;
        }

        /* you can set a style on hover for any module like this */
        #workspaces button {
            padding: 0 5px;
            background: rgba(0, 255, 0, 0.25);
            color: #ffffff;
        }

        #workspaces button.empty {
            background-color: transparent;
        }

        #workspaces button.active {
            background-color: #0000ff;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        #workspaces button.focused {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #mode {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #clock,
        #tray,
        #mode,
        #scratchpad {
            padding: 0 10@x;
            color: #ffffff;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        /*
        #clock {
            background-color: #64727D;
        }
        */

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }

        label:focus {
            background-color: #000000;
        }

        #tray {
            background-color: #2980b9;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
        }

        #scratchpad {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad.empty {
            background-color: transparent;
        }

        #privacy {
            padding: 0;
        }

        #privacy-item {
            padding: 0 5px;
            color: white;
        }

        #privacy-item.screenshare {
            background-color: #cf5700;
        }

        #privacy-item.audio-in {
            background-color: #1ca000;
        }

        #privacy-item.audio-out {
            background-color: #0069d4;
        }
      '';
    };

    wezterm = {
      enable = true;

      extraConfig = ''
        local wezterm = require 'wezterm'

        local config = wezterm.config_builder()

        config.enable_tab_bar = false
        config.font = wezterm.font 'HackGen'
        config.treat_east_asian_ambiguous_width_as_wide = true

        return config
      '';
    };

    wofi = {
      enable = true;
      settings = { show = "run"; };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compmatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
