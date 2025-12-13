
xrandr --output Virtual-1 --mode 1920x1080

GTK_IM_MODULE=fcitx
QT_IM_MOdULE=fcitx
XMODIFIERS=@im=fcitx
fcitx5 &

emacs --daemon

# # import required env variables from the current shell
# systemctl --user import-environment DISPLAY XDG_SESSION_ID
# # start all grahical user services
# systemctl --user start nixos-fake-graphical-session.target
# # start the user dbus daemon
# dbus-daemon --session --address="unix:path=/run/user/$(id -u)/bus" &

xsetroot -cursor_name left_ptr

exec sbcl --load ~/startstump
