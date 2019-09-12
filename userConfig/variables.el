(defconst org-mode-root-file
  (expand-file-name(concat org-mode-dir "/root.org"))
  "Starting point For opening Org-Mode")
(defconst org-mode-journal-dir
  (expand-file-name(concat org-mode-dir "/journal"))
  "Directory For Org-Mode daily files")

(defconst org-mode-daily-file
	(let ((daily-name (format-time-string "%Y-%m-%d")))
	(expand-file-name (concat org-mode-journal-dir "/" daily-name ".org")))
	"Today's org mode journal file")

(defconst org-mode-refile-file
  (expand-file-name(concat org-mode-dir "/refile.org"))
  "File to contain org-mode capture items")

(defun org-mode-daily-file-open ()
  (interactive)
  (find-file org-mode-daily-file))

(defun open-dir (dir)
  (find-file dir)
  (deer))
(defun org-mode-open-dir ()
  (interactive)
  (open-dir org-mode-dir))

;; Define the custum capture templates
;; See http://www.cachestocaches.com/2016/9/my-workflow-org-agenda/
(setq org-capture-templates
      '(("t" "Todo" entry (file org-default-notes-file)
		 "* TODO %?\n%u\n%a\n")
		("m" "Meeting" entry (file org-default-notes-file)
		 "* MEETING with %? :MEETING:\n%t" )
		("i" "Idea" entry (file org-default-notes-file)
		 "* %? :IDEA: \n%t")))

(defun shell-command-to-buffer (command buffer-name)
  "Run a `command' and append its output to buffer `buffer-name'."
  (with-current-buffer (get-buffer-create buffer-name)
    (goto-char (point-max))
    (insert (shell-command-to-string command))))

(defun insert-in-buffer (text buffer-name)
  "Insert `text' in buffer `buffer-name'."
  (with-current-buffer (get-buffer-create buffer-name)
    (insert text)))

(defun minibuffer-get-buffer-file-name ()
  "Returns buffer that was active prior to opening a minibuffer"
  (buffer-file-name (window-buffer (minibuffer-selected-window))))

(defun get-buffer-file-name ()
  "Returns buffer file-name in active window"
  (buffer-file-name (window-buffer (selected-window))))

;(defun open-buffer-in-new-window (buffer-name)
  ;(cond ((eq buffer-name (window-buffer (selected-window)))
        ;;; Visible and focused
        ;)
        ;((get-buffer-window buffer-name)
        ;;; Visible and unfocused
        ;;(set-window-buffer (selected-window) buffer-name)
        ;(display-buffer buffer-name)
        ;)
        ;(t
        ;;; Not Visible
        ;(call-interactively (key-binding "<f3>"))
        ;(display-buffer buffer-name)
        ;)))

