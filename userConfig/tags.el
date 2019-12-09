(require 'counsel-etags)

; Be mindful of the "tags-case-fold-search" variable
; it indicates Whether tags operations should be case-sensitive
;   A value of t means case-insensitive
;   A value of nil means case-sensitive
;   Any other value means use the setting of "case-fold-search".

; Helper function to rebuild tags file at project root
; Project root is definied by projectile
(defun build-ctags ()
  (interactive)
  (message "building project tags")
  ; Get project root
  ;(let ((root (eproject-root)))
  (let ((root (projectile-project-root)))
    ; Requires ctags be installed (exuberent-ctags)
    (shell-command (concat "ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "TAGS " root)))
  ; Reload tags table
  (visit-project-tags)
  (message "tags built successfully"))

; Helper function to load/reload tags file at project root
; Project root is definied by projectile
(defun visit-project-tags ()
  (interactive)
  ;(let ((tags-file (concat (eproject-root) "TAGS")))
  (let ((tags-file (concat (projectile-project-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun my-find-tag ()
  (interactive)
  ;(if (file-exists-p (concat (eproject-root) "TAGS"))
  (if (file-exists-p (concat (projectile-project-root) "TAGS"))
      (visit-project-tags)
    (build-ctags))
  ;(etags-select-find-tag-at-point))
  (counsel-etags-find-tag-at-point))

;(global-set-key (kbd "M-.") 'my-find-tag)

(defconst tag-keys
 '("t" (:which-key "Tag")
   "tt" (my-find-tag :which-key "At Point")
   "tr" (build-ctags :which-key "Refresh")))

(add-keys-to-evil tag-keys)
