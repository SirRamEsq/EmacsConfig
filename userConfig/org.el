;; Requirements
;;  Packages
;;

;; indent orgmode files by default
(setq-default org-startup-indented t)

;; Org tags
(setq org-tag-alist '(
	(:startgroup . nil)
		("@WORK" . ?w) ("@HOME" . ?h)
		("@JW" . ?j)
	(:endgroup . nil)
	(:startgroup . nil)
		("!DEEP" . ?w) ("!SHALLOW" . ?h)
	(:endgroup . nil)
	("software" . ?s)
	))

(with-eval-after-load 'org
(setq org-todo-keywords
	'((sequence "TODO" "WAITING" "NEXT" "|" "DONE" "CANCELLED" "DELEGATED"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "orange" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "magenta" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "cyan" :weight bold)
              ("RV" :foreground "magenta" :weight bold)
              ("PHONE" :foreground "cyan" :weight bold))))

; The triggers break down to the following rules:
  ; Moving a task to CANCELLED adds a CANCELLED tag
  ; Moving a task to WAITING adds a WAITING tag
  ; Moving a task to HOLD adds WAITING and HOLD tags
  ; Moving a task to a done state removes WAITING and HOLD tags
  ; Moving a task to TODO removes WAITING, CANCELLED, and HOLD tags
  ; Moving a task to NEXT removes WAITING, CANCELLED, and HOLD tags
  ; Moving a task to DONE removes WAITING, CANCELLED, and HOLD tags
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(org-babel-do-load-languages 'org-babel-load-languages
'((perl . t)
  (dot . t)
  (R . t)
  (gnuplot . t)
  (clojure . t)
  (lisp . t)
  (stan . t)
  (org . t)
  (screen . t)
  (calc . t)
  (js . t)
  (latex . t)
  (plantuml . t)
  (ruby . t)
  (python . t)
  (emacs-lisp . t)
  (ditaa . t)
  (awk . t)
  (octave . t)
  (sed . t)
  (shell . t)
  (sql . t)
  (sqlite . t)
))


;;;;;;;;;;;;
;; Agenda ;;
;;;;;;;;;;;;
(setq org-agenda-files (list (concat org-mode-dir "/agenda")))

(setq org-agenda-custom-commands
	'(("g" . "GTD contexts")
	("gh" "Home" tags-todo "@HOME")
	("gj" "JW" tags-todo "@JW")
	("gw" "Work" tags-todo "@WORK")
	("G" "GTD Block Agenda"
	)))

;;;;;;;;;;;;;
;; Capture ;;
;;;;;;;;;;;;;

(setq org-default-notes-file org-mode-refile-file)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file org-mode-refile-file)
               "* TODO %?\n%U\n%a\n")
              ("b" "respond" entry (file org-mode-refile-file)
               "* NEXT Respond to %?\n%U\n%a\n")
              ("n" "note" entry (file org-mode-refile-file)
               "* %? :NOTE:\n%U\n%a\n")
              ("j" "Journal" entry (file+datetree org-mode-daily-file)
               "* %?\n%U\n")
              ("m" "Meeting" entry (file org-mode-refile-file)
               "* MEETING with %? :MEETING:\n%U")
              ("r" "RV" entry (file org-mode-refile-file)
               "* RV with %? :RV:\nSCHEDULED:\n%a\n")
              ("p" "Phone call" entry (file org-mode-refile-file)
               "* PHONE %? :PHONE:\n%U")
              ("h" "Habit" entry (file org-mode-refile-file)
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

;; Most note capture sessions probably won't take more than a moment
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)
; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;; Keys
;(add-hook 'org-mode-hook
  ;(lambda ();
  ;(local-set-key (kbd "<return>") 'org-open-at-point)))
