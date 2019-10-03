(require 'json-mode)
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -m json.tool" (current-buffer) t)))

;; Mode Keybindings
;; `general-define-key' is comparable to `define-key' when :keymaps is specified
(general-define-key
 ;; NOTE: keymaps specified with :keymaps must be quoted
 :keymaps 'json-mode-map
 "<f9>" 'beautify-json
    ; Convert Win path "\" to "/"
 )
