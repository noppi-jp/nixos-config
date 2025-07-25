{
    monitor = "Virtual-1, 1920x1080@60, 0x0, 1";

    "$terminal" = "wezterm";
    "$menu" = "wofi";

    #exec-once = [ "waybar" ];

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
}
