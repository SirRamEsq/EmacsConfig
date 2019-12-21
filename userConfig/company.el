;; set default `company-backends'
(setq company-backends
      '((company-files          ; files & directory
         company-keywords       ; keywords
         company-capf           ; CompletAtPointFunction defined by major mode
         ; Seems to be causing problems in gdscript mode

         company-yasnippet
         )
        (company-abbrev company-dabbrev)
        ))
;; Enable Auto-complete globally
(add-hook 'after-init-hook 'global-company-mode)

(setq-default company-idle-delay 0)
; Show suggestions after entering characters
(setq-default company-minimum-prefix-length 2)
(setq-default company-selection-wrap-around t)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)
