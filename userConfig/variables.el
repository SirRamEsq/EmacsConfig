(defconst org-mode-root-file
  (expand-file-name(concat org-mode-dir "/root.org"))
  "Starting point For opening Org-Mode")
(defconst org-mode-journal-dir
  (expand-file-name(concat org-mode-dir "/journal"))
  "Directory For Org-Mode daily files")

(defconst org-mode-daily-file
	(let ((daily-name (format-time-string "%Y-%m-%d [%a]")))
	(expand-file-name (concat org-mode-journal-dir "/" daily-name ".org")))
	"Today's org mode journal file")

(defconst org-mode-weekly-file
	(let ((weekly-name (format-time-string "%Y-%m W%W")))
	(expand-file-name (concat org-mode-journal-dir "/" weekly-name ".org")))
	"Week's org mode journal file")

(defconst org-mode-monthly-file
	(let ((monthly-name (format-time-string "%Y-%m")))
	(expand-file-name (concat org-mode-journal-dir "/" monthly-name ".org")))
	"Month's org mode journal file")

(defconst org-mode-todays-journal
  (cond ((string= (format-time-string "%d") "1") org-mode-monthly-file)
      ((string= (format-time-string "%A") "Monday") org-mode-weekly-file)
      (t org-mode-daily-file))
  "Open relevant Default Journal file for today")

(defconst org-mode-refile-file
  (expand-file-name(concat org-mode-dir "/refile.org"))
  "File to contain org-mode capture items")

(defun org-mode-daily-file-open ()
  (interactive)
  (find-file org-mode-daily-file))

(defun org-mode-weekly-file-open ()
  (interactive)
  (find-file org-mode-weekly-file))

(defun org-mode-monthly-file-open ()
  (interactive)
  (find-file org-mode-monthly-file))

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


(defun xah-open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
  The app is chosen from your OS's preference.

  When called in emacs lisp, if @fname is given, open that.

  URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
  Version 2019-01-18"

  (interactive)
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" $fpath t t))) $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(defun xah-show-in-desktop ()
  "Show current file in desktop.
 (Mac Finder, Windows Explorer, Linux file manager)
 This command can be called when in a file or in `dired'.

  URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
  Version 2018-09-29"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name) default-directory )))
    (cond
     ((string-equal system-type "windows-nt")
      (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" $path t t)))
     ((string-equal system-type "darwin")
      (if (eq major-mode 'dired-mode)
          (let (($files (dired-get-marked-files )))
            (if (eq (length $files) 0)
                (progn
                  (shell-command
                   (concat "open " default-directory)))
              (progn
                (shell-command
                 (concat "open -R " (shell-quote-argument (car (dired-get-marked-files ))))))))
        (shell-command
         (concat "open -R " $path))))
     ((string-equal system-type "gnu/linux")
      (let (
            (process-connection-type nil)
            (openFileProgram (if (file-exists-p "/usr/bin/gvfs-open")
                                 "/usr/bin/gvfs-open"
                               "/usr/bin/xdg-open")))
        (start-process "" nil openFileProgram $path))
      ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. eg with nautilus
      ))))

(defun xah-open-in-terminal ()
  "Open the current dir in a new terminal window.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2017-10-09"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (message "Microsoft Windows not supported. File a bug report or pull request."))
   ((string-equal system-type "darwin")
    (let ((process-connection-type nil))
      (start-process "" nil "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal" default-directory)))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil))
      (start-process "" nil "x-terminal-emulator"
                     (concat "--working-directory=" default-directory))))))
