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
(setq flycheck-display-errors-delay 0)

;; Backup files into temp dir
(defconst emacs-user-backup-dir
  "~/.emacs.d/backup-files"
  "Directory For Emacs backup files")
(setq backup-directory-alist
      `(("." . ,emacs-user-backup-dir)))

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

;; Configure autosave
;; list file is in .emacs.d
;; rest are in auto-save dir
(setq auto-save-list-file-prefix "~/.emacs.d/")
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save/\\1" t))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/auto-save/" t)
(make-directory emacs-user-backup-dir t)

;; No lock files
(setq create-lockfiles nil)

; Always show matching parens immediately
(show-paren-mode 1)
(setq show-paren-delay 0)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

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
(load-user-config-file "indentation.el")


;;;;;;;;;;;;;;;;;;;
;; Auto-complete ;;
;;;;;;;;;;;;;;;;;;;
;; Enable Auto-complete globally
(add-hook 'after-init-hook 'global-company-mode)

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
    (magit company-go flycheck keyfreq exec-path-from-shell airline-themes powerline-evil powerline toml-mode helm-projectile company helm projectile org-agenda-property org-evil ranger evil-leader go-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))
