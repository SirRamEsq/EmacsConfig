(when (>= emacs-major-version 24)
 ; Use the package manager
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
    '("melpa" . "http://melpa.org/packages/") t)
  )

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives
               '("gnu" . "http://elpa.gnu.org/packages/")))

; Initialize the package manager
(package-initialize)
(setq flycheck-display-errors-delay 0)

; Garbage collection
; See http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
; 20MB Threshold
(setq gc-cons-threshold (* 20 1024 1024))

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/auto-save/\\1" t))))
 '(custom-safe-themes
   (quote
    ("645599a2aab022fd7677124515a3104a60ba64d2cafdd77a6e7703f8ae97250c" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "0effdff4be43fd2a90f6bea0ea9abd67f105f15df11045bb5ecd253207d0c9cc" default)))
 '(linum-format " %7i ")
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (yasnippet-snippets ivy-yasnippet yasnippet org-bullets evil-surround which-key swiper-helm counsel-projectile counsel ivy hide-mode-line diminish spaceline beacon evil-mc multiple-cursors crux origami rainbow-delimiters highlight-symbol darkroom focus smart-mode-line-powerline-theme smart-mode-line doom-themes centaur-tabs all-the-icons page-break-lines evil-magit magit company-go flycheck keyfreq exec-path-from-shell airline-themes toml-mode helm-projectile company helm projectile org-agenda-property org-evil ranger evil-leader go-mode evil))))

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

(defun double-flash-mode-line ()
  (let ((flash-sec (/ 1.0 20)))
    (invert-face 'mode-line)
    (run-with-timer flash-sec nil #'invert-face 'mode-line)
    (run-with-timer (* 2 flash-sec) nil #'invert-face 'mode-line)
    (run-with-timer (* 3 flash-sec) nil #'invert-face 'mode-line)))

(setq visible-bell nil
      ring-bell-function 'double-flash-mode-line)

;;;;;;;;;;;;;;;;;;;;;;;
;; User Config Files ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defconst user-config-dir "~/.emacs.d/userConfig" "Location of Configuration Files")

; Function to load config file from user-config-dir
(defun load-user-config-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-config-dir)))

(load-user-config-file "variables-system-specific.el")
(load-user-config-file "variables.el")
(load-user-config-file "OS_SPECIFIC.el")

(load-user-config-file "projectile.el")
(load-user-config-file "evil.el")
(load-user-config-file "general.el")
(load-user-config-file "key-config.el")
(load-user-config-file "ivy.el")
(load-user-config-file "which-key.el")
(load-user-config-file "yasnippet.el")

(load-user-config-file "crux.el")
(load-user-config-file "appearance.el")
;(load-user-config-file "powerline.el")
(load-user-config-file "spaceline.el")

(load-user-config-file "magit.el")
(load-user-config-file "focus.el")
(load-user-config-file "darkroom.el")
(load-user-config-file "origami.el")
(load-user-config-file "beacon.el")
;;(load-user-config-file "centaurTabs.el")
;;(load-user-config-file "dashboard.el")

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




(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centaur-tabs-default ((t (:inherit tabbar-default))))
 '(centaur-tabs-selected ((t (:inherit tabbar-selected))))
 '(centaur-tabs-selected-modified ((t (:inherit tabbar-selected-modified))))
 '(centaur-tabs-unselected ((t (:inherit tabbar-unselected))))
 '(centaur-tabs-unselected-modified ((t (:inherit tabbar-unselected-modified))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1"))))
 '(whitespace-tab ((t (:foreground "#636363")))))
