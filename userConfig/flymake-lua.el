;; use ~/tmp for temp files
(setq flymake-temp-dir (expand-file-name "tmp" "~/"))

; (setq flymake-log-level 3)

(setq flymake-gui-warnings-enabled nil)

(custom-set-faces
 '(flymake-errline ((t (:underline "red"))))
 '(flymake-warnline ((t (:underline "yellow")))))

(defun flymake-lua-setup ()
  (make-local-variable 'flymake-allowed-file-name-masks)
  (make-local-variable 'flymake-err-line-patterns)
  (make-local-variable 'flymake-no-changes-timeout)

  (setq flymake-allowed-file-name-masks
        '(("\\.lua\\'" flymake-lua-init)))
  (setq flymake-err-line-patterns
        '(("^.*luac[0-9.]*\\(.exe\\)?: *\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 2 3 nil 4)))

  (setq flymake-no-changes-timeout 1)
  (flymake-mode 1))


(defun flymake-lua-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-with-folder-structure))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "luac" (list "-p" temp-file))))

(eval-after-load 'flymake
  '(progn
     (defun flymake-get-temp-dir ()
       (if (and (boundp 'flymake-temp-dir)
                (file-readable-p flymake-temp-dir))
           flymake-temp-dir
         temporary-file-directory))))
