;; REQUIREMENTS
;;  Packages
;;   solarized-theme
;;  Fonts
;;   Source Code Variable

(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/")
;; Favorite themes (pick one)
(load-theme 'spolsky t)

;;;;;;;;;;;;;;;;;
;; DOOM THEMES ;;
;;;;;;;;;;;;;;;;;
;;(require 'doom-themes)
;;(load-theme 'doom-vibrant t)
;;(load-theme 'doom-molokai t)
;; Global settings (defaults)
;;(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      ;;doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; Corrects (and improves) org-mode's native fontification.
;;(doom-themes-org-config)
;; Enable flashing mode-line on errors
;;(doom-themes-visual-bell-config)

;(add-hook 'after-init-hook (lambda () (load-theme 'taming-mr-arneson)))

; Use solarized dark (in GUI)
;(when (display-graphic-p) (load-theme 'solarized-dark t))

; Set font in GUI mode
(when (display-graphic-p) (set-face-attribute 'default nil :font "Source Code Variable-12"))

; GUI
(tool-bar-mode -1)
(menu-bar-mode -1) 
(setq inhibit-startup-message t)
(when (display-graphic-p) (set-scroll-bar-mode nil))

