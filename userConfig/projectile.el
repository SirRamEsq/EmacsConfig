(require 'projectile)

(projectile-global-mode)
;(setq projectile-completion-system 'helm)
;(helm-projectile-on)
(setq projectile-completion-system 'ivy)
(counsel-projectile-mode)
