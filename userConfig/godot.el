;(add-to-list 'load-path "~/.emacs.d/packages/emacs-gdscript-mode")
(require 'gdscript-mode)

(setq gdscript-tabs-mode t) ;; If true, use tabs for indents. Default: t
(setq gdscript-tab-width 2) ;; Controls the width of tab-based indents

;; Underscore is part of word
(add-hook 'gdscript-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-to-list 'company-backends 'company-dabbrev-code)
