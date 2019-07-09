(require 'centaur-tabs)
(require 'all-the-icons)
;; See https://github.com/ema2159/centaur-tabs

(centaur-tabs-mode t)

(define-key evil-normal-state-map (kbd "g t") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "g T") 'centaur-tabs-backward)
(define-key evil-normal-state-map (kbd "g r") 'centaur-tabs-forward-group)
(define-key evil-normal-state-map (kbd "g R") 'centaur-tabs-backward-group)

(centaur-tabs-headline-match)
(centaur-tabs-inherit-tabbar-faces)
(setq centaur-tabs-style "slant")
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-bar t)
;; Close button (can be null)
(setq centaur-tabs-close-button "X")
;; Modified buffers
(setq centaur-tabs-set-modified-marker t)
(setq centaur-tabs-modified-marker "*")
;; (setq centaur-tabs--buffer-show-groups t)
(setq centaur-tabs-cycle-scope 'tabs)
