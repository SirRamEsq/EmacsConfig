(setq lsp-keymap-prefix "C-c C-l")

(require 'lsp-mode)
(add-hook 'godot-gdscript-mode-hook #'lsp)

; Which-key integration
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Godot
(defgroup lsp-godot nil
  "LSP support for Godot"
  :group 'lsp-mode
  )

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "godot_editor_launcher")
                  :major-modes '(godot-gdscript-mode)
                  :priority -1
                  :server-id 'gdscriptls))
