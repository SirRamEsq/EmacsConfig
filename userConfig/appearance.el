;; REQUIREMENTS
;;  Packages
;;   solarized-theme
;;  Fonts
;;   Source Code Variable

(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/")
(load-theme 'spolsky t)
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

