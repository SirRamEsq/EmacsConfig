(require 'general)
(require 'srefactor)
(require 'srefactor-lisp)

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
    (set-frame-parameter nil
                         'alpha
                         (if (eql (cond
                                   ((numberp alpha) alpha)
                                   ((numberp (cdr alpha))
                                    (cdr alpha))
                                   ;; Also handle undocumented (<active> <inactive>) form.
                                   ((numberp (cadr alpha))
                                    (cadr alpha)))
                                  100)
                             '(85 . 50)
                           '(100 . 100)))))

(defun org-mode-open-and-refile ()
  (interactive)
  (find-file org-mode-refile-file)
  (org-refile))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prefix Key Mappings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst window-keys
 '("w" (:which-key "Window")
   "wh" (evil-window-left :which-key "Left")
   "wl" (evil-window-right :which-key "Right")
   "wk" (evil-window-up :which-key "Up")
   "wj" (evil-window-down :which-key "Down")
   "w-" (evil-window-decrease-height :which-key "DecHeight")
   "w+" (evil-window-increase-height :which-key "IncHeight")
   "w<" (evil-window-decrease-width :which-key "DecWidth")
   "w>" (evil-window-increase-width :which-key "IncWidth")
   "wf" (make-frame-command :which-key "NewFrame")))

(defconst snippet-keys
 '("s" (:which-key "Snippet")
   "si" (ivy-yasnippet :which-key "Insert")))

(defconst buffer-keys
 '("b" (:which-key "Buffer")
   "bb" (ivy-switch-buffer :which-key "Switch")
   "bl" (evil-next-buffer :which-key "Next")
   "bh" (evil-prev-buffer :which-key "Previous")))

 ; 'l' = Show list of things
(defconst list-keys
 '("l" (:which-key "Lists")
  "ld" (counsel-yank-pop :which-key "KillRing")
  "lt" (counsel-load-theme :which-key "Themes")
  "lk" (counsel-descbinds :which-key "Keys")))

(defconst refactor-keys
 '("r" (:which-key "Refactor")
  "rl" (:which-key "Lisp")
  "rlo" (srefactor-lisp-one-line :which-key "Line")
  "rlm" (srefactor-lisp-format-sexp :which-key "SExp")
  "rld" (srefactor-lisp-format-defun :which-key "Defun")
  "rlb" (srefactor-lisp-format-buffer :which-key "Buffer")))

(defconst find-keys
 '("f" (:which-key "Find")
   "fs" (swiper :which-key "Swiper")
   "fg" (counsel-git-grep :which-key "Grep")))

(defconst org-keys
 '("o" (:which-key "Org")
   "oc" (org-capture :which-key "Capture")
   "ow" (org-mode-open-and-refile :which-key "Refile")
   "ol" (org-store-link :which-key "StoreLink")
   "oi" (org-insert-link :which-key "InsertLink")
   "oo" (org-open-at-point :which-key "OpenLink")))

(defconst highlight-keys
 '("h" '(:which-key "Highlight")
   "hh" '(highlight-symbol :which-key "Symbol")
   "hn" '(highlight-symbol-next :which-key "Next")
   "hp" '(highlight-symbol-prev :which-key "Prev")
   "hr" '(highlight-symbol-query-replace :which-key "QueryReplace")))

(defconst misc-keys
 '("t" (toggle-transparency :which-key "Transparency")
   "x" (counsel-M-x :which-key "M-x")
   "p" (projectile-command-map :which-key "Projectile")
   "-" (text-scale-decrease :which-key "TextDecrease")
   "+" (text-scale-increase :which-key "TextIncrease")
   "ad" (deer :which-key "Deer")))

;;;;;;;;;;;;
;; GLOBAL ;;
;;;;;;;;;;;;
;(global-unset-key (kbd "SPC"))
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
 "<f12>" '(:which-key "Agenda")
 "<f12> w" '(super-agenda-run-work :which-key "Work")
 "<f12> h" '(super-agenda-run-home :which-key "Home")
 "<f12> p" '(super-agenda-run-personal :which-key "Personal")
 "<f12> j" '(super-agenda-run-jw :which-key "JW")
 "<f12> a" '(super-agenda-run-all :which-key "All")
 "C-<f1>" '(org-mode-open-dir :which-key "OpenOrg")
 "M-n" '(org-mode-daily-file-open :which-key "Note")
 "C-x C-e" '(fc-eval-and-replace :which-key "EvalReplace")
)

;;;;;;;;;;
;; EVIL ;;
;;;;;;;;;;
(defun add-keys-to-evil (keys)
 (apply 'general-define-key (append '(
  :states (normal visual insert emacs)
  ; Space in Normal / Visual modes
  :prefix "SPC"
  ; Meta-Space in Insert / Emacs modes
  :non-normal-prefix "M-SPC")
  keys
  ))
)
(add-keys-to-evil window-keys)
(add-keys-to-evil snippet-keys)
(add-keys-to-evil buffer-keys)
(add-keys-to-evil list-keys)
(add-keys-to-evil refactor-keys)
(add-keys-to-evil find-keys)
(add-keys-to-evil org-keys)
;(add-keys-to-evil highlight-keys)
(add-keys-to-evil misc-keys)

;;;;;;;;;;;;;;;;;;;
;; MODE SPECIFIC ;;
;;;;;;;;;;;;;;;;;;;
; All mode specific commands begin with [SPC SPC]

(defun add-keys-to-mode (mode keys)
  (apply 'general-define-key (append '(
  :keymaps mode
  :prefix "SPC")
  keys
  ))
)

(defun open-dir-emacs-d () (interactive) (open-dir "~/.emacs.d/"))
(defun open-dir-work () (interactive) (open-dir (concat org-mode-dir "/work/xplm")))
(defun open-file-work () (interactive) (find-file (concat org-mode-dir "/work/xplm/xplm.org")))
(defun open-file-work-time () (interactive) (find-file (concat org-mode-dir "/work/xplm/time-tracking.org")))
(general-def ranger-mode-map
 :prefix "SPC SPC"
 ; Dirs
 "g" '(:which-key "Dir")
 "go" '(org-mode-open-dir :which-key "Org")
 "ge" '(open-dir-emacs-d :which-key "Emacs")
 "gw" '(open-dir-work :which-key "Work")

 ; Files
 "f" '(:which-key "File")
 "fw" '(:which-key "Work")
 "fww" '(open-file-work :which-key "Work")
 "fwt" '(open-file-work-time :which-key "Time-Tracking")

 ; Open Selected
 "o" '(:which-key "Open")
 "oe" '(xah-show-in-desktop :which-key "Explorer")
 "ot" '(xah-open-in-terminal :which-key "Terminal")
 "oa" '(xah-open-in-external-app :which-key "Application")
)
(add-keys-to-mode ranger-mode-map window-keys)
(add-keys-to-mode ranger-mode-map buffer-keys)
(add-keys-to-mode ranger-mode-map misc-keys)
