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
    bash = {
      enable = true;
      profileExtra = ''
        if uwsm check may-start; then
            exec uwsm start hyprland-uwsm.desktop
        fi
      '';
    };

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

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "Virtual-1, 1920x1080@60, 0x0, 1";

      "$terminal" = "wezterm";
      "$menu" = "wofi";

      exec-once = [ "waybar" ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;

        border_size = 3;

        "col.active_border" = "rgba(ff0000ff)";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "master";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin, 87%"
          "windowsOut, 1, 1.49, linear, popin, 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "jp";
        kb_model = "jp106";
        follow_mouse = 2;
      };

      gestures = {
        workspace_swipe = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";
      "$ctrlMod" = "SUPER_CTRL";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$shiftMod, C, killactive,"
        "$shiftMod, Q, exec, uwsm stop"
        "$ctrlMod, SPACE, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, J, layoutmsg, cyclenext"
        "$mainMod, K, layoutmsg, cycleprev"
        "$ctrlMod, RETURN, layoutmsg, swapwithmaster master"
        "$shiftMod, J, layoutmsg, swapnext"
        "$shiftMod, K, layoutmsg, swapprev"

        "$mainMod, PRINT, exec, hyprshot -m window"
        ", PRINT, exec, hyprshot -m output"
        "$shiftMod, PRINT, exec, hyprshot -m region"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$shiftMod, 1, movetoworkspace, 1"
        "$shiftMod, 2, movetoworkspace, 2"
        "$shiftMod, 3, movetoworkspace, 3"
        "$shiftMod, 4, movetoworkspace, 4"
        "$shiftMod, 5, movetoworkspace, 5"
        "$shiftMod, 6, movetoworkspace, 6"
        "$shiftMod, 7, movetoworkspace, 7"
        "$shiftMod, 8, movetoworkspace, 8"
        "$shiftMod, 9, movetoworkspace, 9"
        "$shiftMod, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$shiftMod, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -1 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      xwayland.force_zero_scaling = true;
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
