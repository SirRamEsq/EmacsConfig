; Packages to install
;  org-evil
;  org-agenda
;  evil
;  evil-leader
;  ranger
;  go-mode
;  helm
;  projectile
;  helm-projectile
;  org-projectile
;  company
;  godot-gdscript

; Use the package manager
(require 'package)

(add-to-list 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives 
               '("gnu" . "http://elpa.gnu.org/packages/")))

; Initialize the package manager
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;
;; User Config Files ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defconst user-config-dir "~/.emacs.d/userConfig" "Location of Configuration Files")

; Function to load config file from user-config-dir
(defun load-user-config-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-config-dir)))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(load-user-config-file "variables-system-specific.el")
(load-user-config-file "variables.el")
(load-user-config-file "evil.el")
(load-user-config-file "general.el")
(load-user-config-file "key-config.el")
(load-user-config-file "appearance.el")
(load-user-config-file "powerline.el")
; Languages
(load-user-config-file "org.el")
(load-user-config-file "go.el")
(load-user-config-file "godot.el")


;;;;;;;;;;;;;;;;;;;
;; Auto-complete ;;
;;;;;;;;;;;;;;;;;;;
;; Enable Auto-complete globally
(add-hook 'after-init-hook 'global-company-mode)
; No delay in showing suggestions.
(setq-default company-idle-delay 0)
; Show suggestions after entering characters
(setq-default company-minimum-prefix-length 2)
(setq-default company-selection-wrap-around t)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("0effdff4be43fd2a90f6bea0ea9abd67f105f15df11045bb5ecd253207d0c9cc" default)))
 '(package-selected-packages
   (quote
	(airline-themes powerline-evil powerline toml-mode helm-projectile company helm projectile org-agenda-property org-evil ranger evil-leader go-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
