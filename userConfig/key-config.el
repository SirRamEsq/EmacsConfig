(require 'highlight-symbol)

(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (print (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))

(defun org-mode-open-and-refile()
  (interactive)
  (find-file org-mode-refile-file)
  (org-refile))

;; <return> is GUI Enter button
;; RET is Terminal Enter button and same as C-m
;; F1 is help
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

(global-set-key (kbd "<f2>") 'split-window-right)
(global-set-key (kbd "<f3>") 'split-window-below)
(global-set-key (kbd "<f4>") 'open-buffer-path)
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "C-<f1>") 'org-mode-open-dir)
(global-set-key (kbd "M-n") 'org-mode-daily-file-open)
(global-set-key (kbd "C-x C-e") 'fc-eval-and-replace)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "<SPC>" 'ivy-yasnippet
  "t" 'toggle-transparency
  ;"bb" 'helm-buffers-list
  "bb" 'ivy-switch-buffer
  "bl" 'evil-next-buffer
  "bh" 'evil-prev-buffer
  ;"x" 'helm-M-x
  "x" 'counsel-M-x
  "ad" 'deer

  ;"pp" 'helm-projectile-switch-project
  ;"pf" 'helm-projectile-find-file
  "p" 'projectile-command-map

  ; 'l' = Show list of things
  ; List of kill ring
  "ld" 'counsel-yank-pop
  ; List of themes
  "lt" 'counsel-load-theme
  ; List of keys
  "lk" 'counsel-descbinds

  ; 's' = Search
  "ss" 'swiper
  ; grep
  "sg" 'counsel-git-grep

  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wk" 'evil-window-up
  "wj" 'evil-window-down

  "wf" 'make-frame-command

  ; Org
  "oc" 'org-capture
  "ow" 'org-mode-open-and-refile
  "ol" 'org-store-link
  "oo" 'org-open-at-point

  "-" 'text-scale-decrease
  "+" 'text-scale-increase

  ; Highlight
  "hh" 'highlight-symbol
  "hn" 'highlight-symbol-next
  "hp" 'highlight-symbol-prev
  "hr" 'highlight-symbol-query-replace

  ; Dirs
  "go" 'org-mode-open-dir
  "ge" (lambda () (interactive) (open-dir "~/.emacs.d/"))
  ; Work
  "gw" (lambda () (interactive) (open-dir (concat org-mode-dir "/work/xplm")))

  ; Files
  ; Work
  "fww" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/xplm.org")))
  ; Work TimeTracking
  "fwt" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/time-tracking.org")))
)

; Supports mode-local bindings
; (evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)

; Increment and decrement numbers
(global-set-key (kbd "C-=") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C--") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "C-=") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)
