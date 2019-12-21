;; Location of Godot Package
(add-to-list 'load-path "~/.emacs.d/packages/godot-gdscript/")

;; load the package
(load "godot-gdscript")

(require 'toml-mode)
(require 'godot-gdscript)

;; Register the desired extensions.
(dolist (pattern '("\\.tscn\\'"
					;; Add more extensions here, if needed.
					))
(add-to-list 'auto-mode-alist (cons pattern 'toml-mode)))
;; Underscore is part of word
(add-hook 'godot-gdscript-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(add-hook 'godot-gdscript-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                         '((company-files company-keywords company-yasnippet)
			   (company-abbrev company-dabbrev)))))
