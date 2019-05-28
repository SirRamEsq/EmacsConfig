(global-set-key (kbd "<f1>") 'org-agenda)
(global-set-key (kbd "<f2>") 'split-window-right)
(global-set-key (kbd "<f3>") 'split-window-below)
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "C-<f1>") 'org-mode-open-dir)
(global-set-key (kbd "M-n") 'org-mode-daily-file-open)
(global-set-key (kbd "M-x") 'helm-M-x)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ad" 'deer

  "pp" 'helm-projectile-switch-project
  "pf" 'helm-projectile-find-file
  "b" 'helm-buffers-list

  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wk" 'evil-window-up
  "wj" 'evil-window-down

  "wf" 'make-frame-command
)

; Supports mode-local bindings
; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
