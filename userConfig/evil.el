;; REQUIREMENTS
;;  Packages
;;   evil
;;   evil-leader

; Give us back Ctrl+U for vim emulation
(setq evil-want-C-u-scroll t)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

; Enable searching with "*" and "#" from visual mode
(add-to-list 'load-path "~/.emacs.d/packages/evil-visualstar/")
(load "evil-visualstar")
(global-evil-visualstar-mode)

(setq evil-search-module 'swiper)

; Use evil mode
(require 'evil-leader)
(global-evil-leader-mode)
(require 'evil)
(evil-mode t)

; Use Evil surround
(require 'evil-surround)
(global-evil-surround-mode 1)

; Escape Key as universal cancel
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
    (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
(with-eval-after-load 'evil
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit))

; Set cursor colors depending on mode
(when (display-graphic-p)
  (setq evil-emacs-state-cursor '("red" hollow))
  (setq evil-normal-state-cursor '("green" hollow))
  (setq evil-visual-state-cursor '("orange" bar))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" hollow))
)

;; :q should kill the current buffer rather than quitting emacs entirely
;(evil-ex-define-cmd "q" 'kill-this-buffer)
