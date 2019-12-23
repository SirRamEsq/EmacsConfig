(require 'git-gutter)

(setq git-gutter:modified-sign " ")
(setq git-gutter:added-sign "")
(setq git-gutter:deleted-sign "-")
(setq git-gutter:window-width 1)

(set-face-background 'git-gutter:modified "yellow") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(global-git-gutter-mode)
(custom-set-variables
 '(git-gutter:handled-backends '(git svn)))
