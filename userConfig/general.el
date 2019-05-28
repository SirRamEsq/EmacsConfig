;; Requires
;;  Packages
;;   ranger

; Default directory handler
; Uses deer instead of dired
(ranger-override-dired-mode t)
;; Show hidden files
(setq-default ranger-show-hidden t)

;; indent with tabs
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq-default evil-shift-width 4)
