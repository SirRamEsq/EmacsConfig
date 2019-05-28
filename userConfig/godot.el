(require 'toml-mode)

;; Register the desired extensions.
(dolist (pattern '("\\.tscn\\'"
					;; Add more extensions here, if needed.
					))
(add-to-list 'auto-mode-alist (cons pattern 'toml-mode)))
