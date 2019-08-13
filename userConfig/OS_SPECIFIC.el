(when (eq system-type 'gnu/linux)
  ;(set-frame-font "Fira Code Retina 15")
  ;; Default Browser
  ;(setq browse-url-browser-function 'browse-url-generic
        ;browse-url-generic-program "firefox"
        ;browse-url-new-window-flag t)
  ;(menu-bar-mode -1)
  ;; enable pdf-tools
  ;(pdf-tools-install))
  ; Display emojii
  ;(set-fontset-font t nil "Symbola" nil 'prepend)

  (defun open-buffer-path ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (let ((shell-cmd-string
   (concat "pcmanfm \"" (file-name-directory) "\""))
    (message (concat "Executing \"" shell-cmd-string "\""))
    (shell-command shell-cmd-string))
  )))

(when (eq system-type 'windows-nt)
  ; Massive performance gain with org bullets and icons
  ; see https://github.com/sabof/org-bullets/issues/11
  (setq inhibit-compacting-font-caches t)

  (defun open-buffer-path ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (let ((shell-cmd-string
   (concat "explorer \""
    (replace-regexp-in-string "/" "\\"
      (file-name-directory (buffer-file-name))t t) "\"")))
    (message (concat "Executing \"" shell-cmd-string "\""))
    (shell-command shell-cmd-string)
    )
  ))
