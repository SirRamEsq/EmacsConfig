;; Location of Godot Package
(add-to-list 'load-path "~/.emacs.d/packages/godot-gdscript.el/")

;; load the package
(load "godot-gdscript")

(require 'toml-mode)

;; Register the desired extensions.
(dolist (pattern '("\\.tscn\\'"
					;; Add more extensions here, if needed.
					))
(add-to-list 'auto-mode-alist (cons pattern 'toml-mode)))
