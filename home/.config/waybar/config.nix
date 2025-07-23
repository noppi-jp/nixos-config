{
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
}
