(require 'spaceline)
(require 'spaceline-config)
(require 'hide-mode-line)


;; EVIL
(defun ph/spaceline-highlight-face-evil-state ()
  "Set the highlight face depending on the evil state."
  (if (bound-and-true-p evil-local-mode)
      (let* ((face (assq evil-state spaceline-evil-state-faces)))
        (if face (cdr face) (spaceline-highlight-face-default)))
    (spaceline-highlight-face-default)))

(setq-default spaceline-highlight-face-func
              'ph/spaceline-highlight-face-evil-state)

(defface ph/spaceline-evil-operator-face
  '((t (:background "cornflower blue"
        :inherit 'spaceline-evil-normal)))
  "Spaceline Evil Operator State"
  :group 'spaceline)

(add-to-list 'spaceline-evil-state-faces
             '(operator . ph/spaceline-evil-operator-face))



;; Flycheck
;(spaceline-define-segment ph/flycheck-error-segment
  ;(if (flycheck-has-current-errors-p)
      ;(let ((c (cdr (assq 'error (flycheck-count-errors
                                    ;flycheck-current-errors)))))
        ;(powerline-raw
         ;(if c (format "%s" c))))))
;
;(spaceline-define-segment ph/flycheck-warning-segment
  ;(if (flycheck-has-current-errors-p)
      ;(let ((c (cdr (assq 'warning (flycheck-count-errors
                                    ;flycheck-current-errors)))))
        ;(powerline-raw
         ;(if c (format "%s" c))))))
;
;(spaceline-define-segment ph/flycheck-info-segment
  ;(if (flycheck-has-current-errors-p)
      ;(let ((c (cdr (assq 'info (flycheck-count-errors
                                    ;flycheck-current-errors)))))
        ;(powerline-raw
         ;(if c (format "%s" c))))))
;
;(defface ph/spaceline-flycheck-error-face
  ;'((t :inherit 'mode-line
       ;:weight bold
       ;:foreground "white"
       ;:background "dark red"))
  ;"Flycheck Error Face"
  ;:group 'spaceline)
;
;(defface ph/spaceline-flycheck-warning-face
  ;'((t :inherit 'mode-line
       ;:weight bold
       ;:foreground "white"
       ;:background "DarkOrange3"))
  ;"Flycheck Warning Face"
  ;:group 'spaceline)

;(defface ph/spaceline-flycheck-info-face
  ;'((t :inherit 'mode-line
       ;:weight bold
       ;:foreground "white"
       ;:background "dark green"))
  ;"Flycheck Info Face"
  ;:group 'spaceline)



; Git Branch
(defun ph/git-branch-name ()
  (replace-regexp-in-string "^ Git[:-]" "" vc-mode))

(spaceline-define-segment ph/version-control
  "Version control information."
  (when vc-mode
    (s-trim (concat (ph/git-branch-name)))))



;; TRAMP
(spaceline-define-segment ph/remote-method
  (when (and default-directory
             (file-remote-p default-directory 'method))
    (file-remote-p default-directory 'method)))

(spaceline-define-segment ph/remote-user-and-host
  (when (and default-directory
             (or
              (file-remote-p default-directory 'user)
              (file-remote-p default-directory 'host)))
    (concat
     (file-remote-p default-directory 'user) "@"
     (file-remote-p default-directory 'host))))

(defface ph/spaceline-tramp-user-host-face
  '((t :inherit 'mode-line
       :foreground "black"
       :background "#fce94f"))
  "Tramp User@Host Face"
  :group 'spaceline)

(defface ph/spaceline-tramp-method-face
  '((t :inherit 'mode-line
       :foreground "black"
       :background "#ff5d17"))
  "Tramp Method Face"
  :group 'spaceline)

;; Org timer
(spaceline-define-segment org-timer-left-time
  "Show the time left in the current org-timer (i.e. a pomodoro)."
  (when (boundp 'org-timer-countdown-timer)
    (if org-timer-countdown-timer
      (let* ((rtime (decode-time
                     (time-subtract (timer--time org-timer-countdown-timer)
                                    (current-time))))
             (rsecs (nth 0 rtime))
             ;; Show time only in 15s increments (so it's not too
             ;; distracting). This could probably done in math instead
             ;; of a cond statement.
             (dsecs (cond
                     ((>= rsecs 45) 45)
                     ((>= rsecs 30) 30)
                     ((>= rsecs 15) 15)
                     ((< rsecs 15) 0)))
             (rmins (nth 1 rtime)))
        (format "%02d:%02d" rmins dsecs)))))

;; Setup
(spaceline-emacs-theme)
(spaceline-install
  'main
  '((evil-state :face highlight-face)
    (buffer-id)
    (org-timer-left-time)
    ;; (ph/mu4e-context-segment :face 'ph/spaceline-mu4e-context-face)
    (ph/remote-method :face 'ph/spaceline-tramp-method-face)
    (ph/remote-user-and-host :face 'ph/spaceline-tramp-user-host-face)
    (buffer-modified))
  '(;;(minor-modes :when active)
    (projectile-root)
    (ph/version-control)
    ;(line-column :when active)
    ;(buffer-position :when active)
    (ph/flycheck-info-segment :face 'ph/spaceline-flycheck-info-face :when active)
    (ph/flycheck-warning-segment :face 'ph/spaceline-flycheck-warning-face :when active)
    (ph/flycheck-error-segment :face 'ph/spaceline-flycheck-error-face :when active)
    (line-column)
    (major-mode)))

(defun powerline-selected-window-active () t)


;; Diminish (cut down on modeline clutter)
(eval-after-load "auto-revert"
  '(diminish 'auto-revert-mode))
(eval-after-load "beacon"
  '(diminish 'beacon-mode))
(eval-after-load "ivy"
  '(diminish 'ivy-mode))
(eval-after-load "projectile"
  '(diminish 'projectile-mode))
(eval-after-load "projectile-rails"
  '(diminish 'projectile-rails-mode))
(eval-after-load "rainbow-mode"
  '(diminish 'rainbow-mode))
(eval-after-load "undo-tree"
  '(diminish 'undo-tree-mode))
(eval-after-load "which-key"
  '(diminish 'which-key-mode))

;; When to hide the modeline entirely
(add-hook 'pdf-view-mode-hook #'hide-mode-line-mode)
