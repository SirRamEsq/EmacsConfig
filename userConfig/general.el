(require 'general)

;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;
;; GLOBAL ;;
;;;;;;;;;;;;
(general-define-key
 "<f1> f" '(counsel-describe-function :which-key "Desc Function")
 "<f1> v" '(counsel-describe-variable :which-key "Desc Variable")
 "<f1> l" '(counsel-find-library :which-key "Find Library")
 "<f1> i" '(counsel-info-lookup-symbol :which-key "Find Symbol")
 "<f1> u" '(counsel-info-lookup-symbol :which-key "Unicode Char")
 "<f2>" '(split-window-right :which-key "Split-Right")
 "<f3>" '(split-window-below :which-key "Split-Below")
 "<f4>" '(open-buffer-path :which-key "OpenBufferPath")
 "<f9>" '(compile :which-key "Compile")
 "<f12>" '(org-agenda :which-key "Agenda")
 "C-<f1>" '(org-mode-open-dir :which-key "OpenOrg")
 "M-n" '(org-mode-daily-file-open :which-key "Note")
 "C-x C-e" '(fc-eval-and-replace :which-key "EvalReplace")
)

;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE PREFIX KEY ;;
;;;;;;;;;;;;;;;;;;;;;;;
(general-define-key
 :states '(normal visual insert emacs)
 ; Space in Normal / Visual modes
 :prefix "SPC"
 ; Meta-Space in Insert / Emacs modes
 :non-normal-prefix "M-SPC"
  "<SPC>" '(ivy-yasnippet :which-key "Snippet")
  "t" '(toggle-transparency :which-key "Transparency")
  ;"bb" 'helm-buffers-list
  "b" '(:which-key "Buffer")
  "bb" '(ivy-switch-buffer :which-key "Switch")
  "bl" '(evil-next-buffer :which-key "Next")
  "bh" '(evil-prev-buffer :which-key "Previous")
  ;"x" 'helm-M-x
  "x" '(counsel-M-x :which-key "M-x")
  "ad" '(deer :which-key "Deer")

  ;"pp" 'helm-projectile-switch-project
  ;"pf" 'helm-projectile-find-file
  "p" '(projectile-command-map :which-key "Projectile")

  ; 'l' = Show list of things
  "l" '(:which-key "Lists")
  ; List of kill ring
  "ld" '(counsel-yank-pop :which-key "KillRing")
  ; List of themes
  "lt" '(counsel-load-theme :which-key "Themes")
  ; List of keys
  "lk" '(counsel-descbinds :which-key "Keys")

  "s" '(:which-key "Search")
  "ss" '(swiper :which-key "Swiper")
  "sg" '(counsel-git-grep :which-key "Grep")

  "w" '(:which-key "Window")
  "wh" '(evil-window-left :which-key "Left")
  "wl" '(evil-window-right :which-key "Right")
  "wk" '(evil-window-up :which-key "Up")
  "wj" '(evil-window-down :which-key "Down")

  "wf" '(make-frame-command :which-key "NewFrame")

  ; Org
  "o" '(:which-key "Org")
  "oc" '(org-capture :which-key "Capture")
  "ow" '(org-mode-open-and-refile :which-key "Refile")
  "ol" '(org-store-link :which-key "StoreLink")
  "oo" '(org-open-at-point :which-key "OpenLink")

  "-" '(text-scale-decrease :which-key "TextDecrease")
  "+" '(text-scale-increase :which-key "TextIncrease")

  ; Highlight
  "h" '(:which-key "Highlight")
  "hh" '(highlight-symbol :which-key "Symbol")
  "hn" '(highlight-symbol-next :which-key "Next")
  "hp" '(highlight-symbol-prev :which-key "Prev")
  "hr" '(highlight-symbol-query-replace :which-key "QueryReplace")

  ; Dirs
  "g" '(:which-key "Dir")
  "go" '(org-mode-open-dir :which-key "Org")
  "ge" (lambda () (interactive) (open-dir "~/.emacs.d/")
        :which-key "Emacs")
  ; Work
  "gw" (lambda () (interactive) (open-dir (concat org-mode-dir "/work/xplm"))
        :which-key "Work")

  ; Files
  "f" '(:which-key "File")
  ; Work
  "fww" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/xplm.org"))
          :which-key "Work")
  ; Work TimeTracking
  "fwt" (lambda () (interactive) (find-file (concat org-mode-dir "/work/xplm/time-tracking.org"))
          :which-key "Work TimeTracking")
)

