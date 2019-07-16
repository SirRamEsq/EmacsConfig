(require 'multiple-cursors)
(require 'evil-mc)

;; See https://github.com/gabesoft/evil-mc/blob/master/evil-mc-setup.el
(evil-define-key 'visual evil-mc-key-map
  "A" #'evil-mc-make-cursor-in-visual-selection-end
  "I" #'evil-mc-make-cursor-in-visual-selection-beg)

;(defvar evil-mc-mode-line-prefix "M"
  ;"Override of the default mode line string for `evil-mc-mode'.")

(global-evil-mc-mode 1)
