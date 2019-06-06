;; Requires
;;  Packages
;;   go-mode
(setq gofmt-command "goimports")

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (flycheck-mode)
  ; Godef jump key binding
  (local-set-key (kbd "M-j") 'godef-jump)
  (local-set-key (kbd "M-k") 'godef-describe)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)
