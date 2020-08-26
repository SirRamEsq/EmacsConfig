(require 'projectile)

; See
; https://docs.projectile.mx/projectile/configuration.html

(projectile-global-mode)
;(setq projectile-completion-system 'helm)
;(helm-projectile-on)
(setq projectile-completion-system 'ivy)
(counsel-projectile-mode)

;;;;;;;;;;;;;;
;; INDEXING ;;
;;;;;;;;;;;;;;

;(setq projectile-indexing-method 'native)
(setq projectile-indexing-method 'hybrid)
;(setq projectile-indexing-method 'alien)


;;;;;;;;;;;;;
;; SORTING ;;
;;;;;;;;;;;;;

; The default is to not sort files:
; (setq projectile-sort-order 'default)

; To sort files by recently opened:
; (setq projectile-sort-order 'recentf)

; To sort files by recently active buffers and then recently opened files:
; (setq projectile-sort-order 'recently-active)

; To sort files by modification time (mtime):
(setq projectile-sort-order 'modification-time)

; To sort files by access time (atime):
; (setq projectile-sort-order 'access-time)

;;;;;;;;;;;
;; CACHE ;;
;;;;;;;;;;;

; Disable REMOTE file exists cache (ie, TRAMP / SSH)
(setq projectile-file-exists-remote-cache-expire nil)

