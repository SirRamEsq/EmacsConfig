;; Requirements
;;  Packages
;;
(require 'org-bullets)
(require 'org)

;; Load ODT backend to allow for exporting to open document format.
(require 'ox-odt)
;; Prefer outputting to docx
(setq org-odt-preferred-output-format "docx")

;; indent orgmode files by default
(setq-default org-startup-indented t)

;; Org tags
(setq org-tag-alist '((:startgroup . nil)
                      ("@XPLM" . ?w)
                      ("@HOME" . ?h)
                      ("@JW" . ?j)
                      (:endgroup . nil)
                      (:startgroup . nil)
                      ("!DEEP" . ?w)
                      ("!SHALLOW" . ?h)
                      (:endgroup . nil)
                      ("software" . ?s)))

(with-eval-after-load 'org
  (setq org-todo-keywords '((sequence "TODO" "WAITING" "NEXT" "|" "DONE"
                                      "CANCELLED" "DELEGATED"))))

(setq org-todo-keyword-faces (quote (("TODO" :foreground "red"
                                      :weight bold)
                                     ("NEXT" :foreground "orange"
                                      :weight bold)
                                     ("DONE" :foreground "forest green"
                                      :weight bold)
                                     ("WAITING" :foreground "magenta"
                                      :weight bold)
                                     ("HOLD" :foreground "magenta"
                                      :weight bold)
                                     ("CANCELLED" :foreground "forest green"
                                      :weight bold)
                                     ("MEETING" :foreground "cyan"
                                      :weight bold)
                                     ("RV" :foreground "magenta"
                                      :weight bold)
                                     ("PHONE" :foreground "cyan"
                                      :weight bold))))

                                        ; The triggers break down to the following rules:
                                        ; Moving a task to CANCELLED adds a CANCELLED tag
                                        ; Moving a task to WAITING adds a WAITING tag
                                        ; Moving a task to HOLD adds WAITING and HOLD tags
                                        ; Moving a task to a done state removes WAITING and HOLD tags
                                        ; Moving a task to TODO removes WAITING, CANCELLED, and HOLD tags
                                        ; Moving a task to NEXT removes WAITING, CANCELLED, and HOLD tags
                                        ; Moving a task to DONE removes WAITING, CANCELLED, and HOLD tags


(setq org-todo-state-tags-triggers (quote (("CANCELLED"
                                            ("CANCELLED" . t))
                                           ("WAITING"
                                            ("WAITING" . t))
                                           ("HOLD"
                                            ("WAITING")
                                            ("HOLD" . t))
                                           (done ("WAITING")
                                                 ("HOLD"))
                                           ("TODO"
                                            ("WAITING")
                                            ("CANCELLED")
                                            ("HOLD"))
                                           ("NEXT"
                                            ("WAITING")
                                            ("CANCELLED")
                                            ("HOLD"))
                                           ("DONE"
                                            ("WAITING")
                                            ("CANCELLED")
                                            ("HOLD")))))

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
                               (sqlite . t)))


;;;;;;;;;;;;;;;;
;; APPEARANCE ;;
;;;;;;;;;;;;;;;;
                                        ;(setq org-ellipsis "..▼")
;; make available "org-bullet-face" such that I can control the font size individually
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode 1)))
                                        ;(setq org-bullets-face-name (quote org-bullet-face))
                                        ;(setq org-bullets-bullet-list '("○" "◎" "◉" "●" "" "" "" "" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"))
