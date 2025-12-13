(load-module :stumptray)
(load-module :swm-gaps)
(load-module :screenshot)

(set-font "-*-unifont-medium-r-normal-*-*-*-*-*-*-*-*-*")

(set-focus-color "red")
(setf *normal-border-width* 3)

(mode-line)
(stumptray::stumptray)

(define-key *root-map* (kbd "C-c") "exec wezterm")
(define-key *root-map* (kbd "C-e") "exec emacsclient -r")

(setf swm-gaps:*outer-gaps-size* 5)
(swm-gaps:toggle-gaps-on)
