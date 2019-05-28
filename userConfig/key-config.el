(global-set-key (kbd "<f1>") 'org-agenda)
(global-set-key (kbd "C-<f1>") 'org-mode-open-dir)
(global-set-key (kbd "<f2>") 'split-window-right)
(global-set-key (kbd "M-n") 'org-mode-daily-file-open)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ad" 'deer
  "pp" 'helm-projectile-switch-project
  "pf" 'helm-projectile-find-file
  "b" 'helm-buffers-list)

; Supports mode-local bindings
; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)
