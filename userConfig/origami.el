(require 'origami)

(global-origami-mode)
(define-key evil-normal-state-map "zO" 'origami-open-node-recursively)
(define-key evil-normal-state-map "zo" 'origami-open-node)
(define-key evil-normal-state-map "zM" 'origami-close-all-nodes)
(define-key evil-normal-state-map "zt" 'origami-toggle-node)
(define-key evil-normal-state-map "zT" 'origami-recursively-toggle-node)
(define-key evil-normal-state-map "zR" 'origami-reset)
(define-key evil-normal-state-map "zr" 'origami-redo)
(define-key evil-normal-state-map "zu" 'origami-undo)
(define-key evil-normal-state-map "zn" 'origami-next-fold)
(define-key evil-normal-state-map "zp" 'origami-previous-fold)