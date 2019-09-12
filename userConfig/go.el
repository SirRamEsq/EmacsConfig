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

;; Mode Keybindings
;; `general-define-key' is comparable to `define-key' when :keymaps is specified
(general-define-key
 ;; NOTE: keymaps specified with :keymaps must be quoted
 :keymaps 'go-mode-map
 "<f9>" (lambda() (interactive)
    ; Convert Win path "\" to "/"
    (let ((go-path-buffer (concat (subst-char-in-string ?\\ ?/ (getenv "GOPATH")) "/src/")))
      (when (eq system-type 'windows-nt)
        ; Make Drive letter lowercase ("C:\" becomes "c:\")
        (setq go-path-buffer (concat
          (s-downcase (s-left 1 go-path-buffer))
          (s-right (- (length go-path-buffer) 1) go-path-buffer)))
      )
      ; When buffer is a sub-dir of GOPATH
      (when (string-prefix-p go-path-buffer (get-buffer-file-name))
        (let
          ((static-check-path (file-name-directory (s-chop-prefix go-path-buffer (get-buffer-file-name)))))
          (insert-in-buffer "\n=====\nBuilding...\n" "*go-terminal*")
          (shell-command-to-buffer "go build" "*go-terminal*")
          (insert-in-buffer "\nTesting...\n" "*go-terminal*")
          (shell-command-to-buffer "go test" "*go-terminal*")
          (insert-in-buffer "\nStatic Check...\n" "*go-terminal*")
          (shell-command-to-buffer (concat "staticcheck -tests " static-check-path "/...") "*go-terminal*")
        )
      )
    )
  )
 )
