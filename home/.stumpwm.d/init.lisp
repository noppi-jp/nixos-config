(load-module :stumptray)

(set-font "-*-unifont-medium-r-normal-*-*-*-*-*-*-*-*-*")
;; (run-shell-command "xrandr --output Virtual-1 --mode 1920x1080")
;; (run-shell-command "fcitx5 &")
(mode-line)
(stumptray::stumptray)

(define-key *root-map* (kbd "C-c") "exec wezterm")
(define-key *root-map* (kbd "C-e") "exec emacsclient -r")
