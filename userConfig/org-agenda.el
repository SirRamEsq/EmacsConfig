(require 'org-agenda)

;;;;;;;;;;;;
;; Agenda ;;
;;;;;;;;;;;;
;(setq org-agenda-files (list (concat org-mode-dir "/agenda")))

;(setq org-agenda-custom-commands '(("g" . "GTD contexts")
                                   ;("gh" "Home" tags-todo "@HOME")
                                   ;("gj" "JW" tags-todo "@JW")
                                   ;("gw" "Work"
                                    ;tags-todo
                                    ;"@WORK"
                                    ;;; todos sorted by context
                                    ;((org-agenda-prefix-format "[%b]\n  ")
                                     ;(org-agenda-sorting-strategy '(tag-up priority-down))
                                     ;(org-agenda-todo-keyword-format "%-1s")
                                     ;(org-agenda-overriding-header "Work Tasks\n"))
                                    ;((org-agenda-with-colors t)
                                     ;(org-agenda-compact-blocks t)
                                     ;(org-agenda-remove-tags t)
                                     ;))
                                   ;("P" "Printed agenda"
                                    ;((agenda ""
                                             ;((org-agenda-span 7) ;; overview of appointments
                                              ;(org-agenda-start-on-weekday nil) ;; calendar begins today
                                              ;(org-agenda-repeating-timestamp-show-all t)
                                              ;(org-agenda-entry-types '(:timestamp :sexp))))
                                     ;(agenda ""
                                             ;((org-agenda-span 1) ; daily agenda
                                              ;(org-deadline-warning-days 7) ; 7 day advanced warning for deadlines
                                              ;(org-agenda-todo-keyword-format "[ ]")
                                              ;(org-agenda-scheduled-leaders '("" ""))
                                              ;(org-agenda-prefix-format "%t%s")))
                                     ;(todo "TODO"
                                           ;;; todos sorted by context
                                           ;((org-agenda-prefix-format "[ ] %T: ")
                                            ;(org-agenda-sorting-strategy '(tag-up priority-down))
                                            ;(org-agenda-todo-keyword-format "")
                                            ;(org-agenda-overriding-header "\nTasks by Context\n------------------\n"))))
                                    ;((org-agenda-with-colors nil)
                                     ;(org-agenda-compact-blocks t)
                                     ;(org-agenda-remove-tags t)
                                     ;(ps-number-of-columns 2)
                                     ;(ps-landscape-mode t))
                                    ;("~/agenda.ps"))
                                   ;; other commands go here
                                   ;))

;;;;;;;;;;;;;;;;;;
;; Super-Agenda ;;
;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;
;; Capture ;;
;;;;;;;;;;;;;

(setq org-default-notes-file org-mode-refile-file)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates (quote (("t" "todo"
                                     entry
                                     (file org-mode-refile-file)
                                     "* TODO %?\n%U\n%a\n")
                                    ("b" "respond"
                                     entry
                                     (file org-mode-refile-file)
                                     "* NEXT Respond to %?\n%U\n%a\n")
                                    ("n" "note"
                                     entry
                                     (file org-mode-refile-file)
                                     "* %? :NOTE:\n%U\n%a\n")
                                    ("j" "Journal"
                                     entry
                                     (file+datetree org-mode-daily-file)
                                     "* %?\n%U\n")
                                    ("m" "Meeting"
                                     entry
                                     (file org-mode-refile-file)
                                     "* MEETING with %? :MEETING:\n%U")
                                    ("r" "RV"
                                     entry
                                     (file org-mode-refile-file)
                                     "* RV with %? :RV:\nSCHEDULED:\n%a\n")
                                    ("p" "Phone call"
                                     entry
                                     (file org-mode-refile-file)
                                     "* PHONE %? :PHONE:\n%U")
                                    ("h" "Habit"
                                     entry
                                     (file org-mode-refile-file)
                                     "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK"
                                (point))))

;; Most note capture sessions probably won't take more than a moment
                                        ;(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

                                        ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel .
                                      9)
                                 (org-agenda-files :maxlevel .
                                                   9))))

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
  (not (member (nth 2
                    (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;; Keys
                                        ;(add-hook 'org-mode-hook
                                        ;(lambda ();
                                        ;(local-set-key (kbd "S-<return>") 'org-open-at-point)))
                                        ;(define-key evil-normal-state-map "<return>" 'origami-open-node-recursively)))
