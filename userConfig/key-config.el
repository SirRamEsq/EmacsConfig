(defun org-mode-open-and-refile()
  (interactive)
  (find-file org-mode-refile-file)
  (org-refile))

(global-set-key (kbd "<f1>") 'org-agenda)
(global-set-key (kbd "<f2>") 'split-window-right)
(global-set-key (kbd "<f3>") 'split-window-below)
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "C-<f1>") 'org-mode-open-dir)
(global-set-key (kbd "M-n") 'org-mode-daily-file-open)
(global-set-key (kbd "M-x") 'helm-M-x)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "b" 'helm-buffers-list
  "x" 'helm-M-x
  "ad" 'deer

  "pp" 'helm-projectile-switch-project
  "pf" 'helm-projectile-find-file

  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wk" 'evil-window-up
  "wj" 'evil-window-down

  "wf" 'make-frame-command

  ; Org
  "oc" 'org-capture
  "ow" 'org-mode-open-and-refile
  "ol" 'org-store-link

  ; Dirs
  "go" 'org-mode-open-dir
  "ge" (lambda () (interactive) (open-dir "~/.emacs.d/"))
  ; Work
  "gw" (lambda () (interactive) (open-dir (concat org-mode-dir "/work/xplm")))

  ; Files
  ; Work
  "fww" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/xplm.org")))
  ; Work TimeTracking
  "fwt" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/time-tracking.org")))
)

; Supports mode-local bindings
; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
