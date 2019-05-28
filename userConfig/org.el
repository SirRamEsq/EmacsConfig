;; Requirements
;;  Packages
;;   

;; indent orgmode files by default
(setq-default org-startup-indented t)

;; Org tags
(setq org-tag-alist '((:startgroup . nil)
	("@WORK" . ?w) ("@HOME" . ?h)
	("@JW" . ?j)
	(:endgroup . nil)
	(:startgroup . nil)
	("!DEEP" . ?w) ("!SHALLOW" . ?h)
	(:endgroup . nil)
	("software" . ?s) ))

(with-eval-after-load 'org
(setq org-todo-keywords
	'((sequence "TODO" "WAITING" "VERIFY" "|" "DONE" "CANCELLED" "DELEGATED"))))

(with-eval-after-load 'org
(setq-default org-todo-keyword-faces
	(quote (
			("CANCELLED" :foreground "orange" :weight bold)
			("DELEGATED" :foreground "green" :weight bold)
			("VERIFY" :foreground "cyan" :weight bold)
			("WAITING" :foreground "cyan" :weight bold)))))


(setq org-agenda-files (list (concat org-mode-dir "/agenda")))

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
