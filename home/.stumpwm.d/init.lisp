(require :swank)
(swank:create-server :port 4004
                     :dont-close t)

(load-module :stumptray)
(load-module :swm-gaps)
(load-module :screenshot)

(set-font "-*-unifont-medium-r-normal-*-*-*-*-*-*-*-*-*")

(set-focus-color "red")
(setf *normal-border-width* 3)

(setf *screen-mode-line-format* "[^B%n^b] %W^>%d            ")
(setf *time-format-string-default* "%Y/%m/%d (%a) %H:%M:%S")
(setf *time-modeline-string* "%Y/%m/%d (%a) %H:%M")

(mode-line)
(stumptray::stumptray)

(define-key *root-map* (kbd "C-c") "exec wezterm")
(define-key *root-map* (kbd "C-e") "exec emacsclient -r")

(setf swm-gaps:*outer-gaps-size* 5)
(swm-gaps:toggle-gaps-on)
