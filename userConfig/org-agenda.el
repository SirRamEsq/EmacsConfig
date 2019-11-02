(require 'org-agenda)
(require 'ts)

(require 'org-capture)
(require 'org-protocol)
(setq org-protocol-default-template-key "l")
;(with-eval-after-load 'org
  ;(add-to-list 'org-modules 'org-protocol t))

;;;;;;;;;;;;
;; Agenda ;;
;;;;;;;;;;;;
(setq org-agenda-files (list (concat org-mode-dir "/agenda")))
(setq org-columns-default-format
      "%PROPERTY[(CATEGORY)] %TODO %3PRIORITY %40ITEM(Task) %DEADLINE")
                                        ; Hide these tags
;(setq org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "@HOME\\|@JW\\|@WORK"))
(setq org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "@WORK"))
(setq org-agenda-custom-commands '(("g" . "GTD contexts")
                                   ("ga" "All"
                                    ((agenda "")
                                     (alltodo "")))
                                   ("gh" "Home"
                                    ((agenda "")
                                     (tags-todo "@HOME")))
                                   ("gp" "Personal"
                                    ((agenda "")
                                     (tags-todo "-@WORK-@LOUIE")))
                                   ("gl" "Louie"
                                    ((agenda "")
                                     (tags-todo "@LOUIE")))
                                   ("gj" "JW"
                                    ((agenda "")
                                     (tags-todo "@JW")))
                                   ("gw" "Work"
                                    ((agenda "")
                                    (tags-todo
                                    "@WORK"
                                        ; todos sorted by context
                                    ;((org-agenda-prefix-format "")
                                     ;(org-agenda-sorting-strategy '(tag-up priority-down))
                                     ;(org-agenda-todo-keyword-format "%-1s")
                                     ;)
                                        ;(org-agenda-overriding-header "Work Tasks\n"))
                                    ;((org-agenda-with-colors t)
                                     ;(org-agenda-compact-blocks t)
                                     ;(org-agenda-remove-tags t))
                                    ;)
                                   ;; other commands go here
                                   )))))

;;;;;;;;;;;;;;;;;;
;; Super-Agenda ;;
;;;;;;;;;;;;;;;;;;

; Play nice with Evil
(setq org-super-agenda-header-map (make-sparse-keymap))

(defun super-agenda-run (view)
  (interactive)
  (org-super-agenda-mode)
  (let ((org-super-agenda-groups `( ;; Each group has an implicit boolean OR operator between its selectors.
                                   ;(:name "Today" :time-grid t
                                          ;:scheduled today)
                                   (:name "Important" :priority "A")
                                   (:name "Overdue" :deadline past)
                                   (:name "Today" :deadline today)
                                   (:name "Due Soon"
                                          :deadline (before ,(ts-format (ts-adjust 'day 30 (ts-now))))
                                          ; Throw out these TODOs, don't pass to next filter
                                          :discard (
                                                    :deadline
                                                     (after ,(ts-format (ts-adjust 'day 30 (ts-now))))))
                                   (:name "Project" :auto-property "PROJECT")
                                   (:todo "WAITING" :order 8) ; Set order of this section
                                   (:name "Due Eventually" :order 100 :deadline future)
                                   (:priority<= "B"
                                                ;; Show this section after "Today" and "Important", because
                                                ;; their order is unspecified, defaulting to 0. Sections
                                                ;; are displayed lowest-number-first.
                                                :order 1))))
    (org-agenda nil view)))

(defun super-agenda-run-work ()
  (interactive)
  (super-agenda-run "gw"))
(defun super-agenda-run-home ()
  (interactive)
  (super-agenda-run "gh"))
(defun super-agenda-run-personal ()
  (interactive)
  (super-agenda-run "gp"))
(defun super-agenda-run-Louie ()
  (interactive)
  (super-agenda-run "gl"))
(defun super-agenda-run-jw ()
  (interactive)
  (super-agenda-run "gj"))
(defun super-agenda-run-all ()
  (interactive)
  (super-agenda-run "ga"))

;;;;;;;;;;;;;
;; Capture ;;
;;;;;;;;;;;;;

(setq org-default-notes-file org-mode-refile-file)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates (quote (("t" "todo" entry
                                     (file org-mode-refile-file)
                                     "* TODO %?\n%U\n%a\n")
                                    ("b" "respond" entry
                                     (file org-mode-refile-file)
                                     "* NEXT Respond to %?\n%U\n%a\n")
                                    ("n" "note" entry
                                     (file org-mode-refile-file)
                                     "* %? :NOTE:\n%U\n%a\n")
                                    ("j" "Journal" entry
                                     (file+datetree org-mode-daily-file)
                                     "* %?\n%U\n")
                                    ("m" "Meeting" entry
                                     (file org-mode-refile-file)
                                     "* MEETING with %? :MEETING:\n%U")
                                    ("r" "RV" entry
                                     (file org-mode-refile-file)
                                     "* RV with %? :RV:\nSCHEDULED:\n%a\n")
                                    ("P" "Phone call" entry
                                     (file org-mode-refile-file)
                                     "* PHONE %? :PHONE:\n%U")
                                    ("p" "Protocol" entry
                                     (file+headline org-mode-refile-file "Protocols")
                                     "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                                    ("L" "Protocol Link" entry
                                     (file+headline org-mode-refile-file "Protocol Links")
                                      "* %? [[%:link][%:description]] \nCaptured On: %U")
                                    ("h" "Habit" entry
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
