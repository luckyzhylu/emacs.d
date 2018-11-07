(require 'eassit)
(defun zyl-eassit-hook()
  (define-key c-mode-base-map (kbd "C-c o") 'eassist-switch-h-cpp)
  (define-key c-mode-base-map (kbd "C-c l") 'eassist-list-methods)
  )
;; (add-hook 'c-mode-common-hook 'zyl-eassit-hook)
;; (setq company-backends '((company-files company-keywords  company-capf company-yasnippet)
;;                          (company-abbrev company-dabbrev)))

;; (add-hook 'c-mode-common-hook
;;           (lambda()
;;             (add-to-list (make-local-variable 'company-backends) 
;;                          ((company-clang company-gtags company-etags company-dabbrev-code company-semantic company-files company-keywords  company-capf company-yasnippet)
;;                           (company-abbrev company-dabbrev))
;;                          )
;;             '(company-show-numbers t)
;;             ))
;; (add-hook 'python-mode-hook
;;           (lambda()
;;             (add-to-list (make-local-variable 'company-backends) 'company-anaconda)))x
;; (global-set-key "\t" 'company-complete-common)
;; (global-set-key)

;; autoinsert
(auto-insert-mode 1)
;; (setq auto-insert t)
;; (setq auto-insert-query nil)
(setq auto-insert-directory
      (file-name-as-directory
       (expand-file-name "~/.emacs.d/etc/templates"
                         (file-name-directory (or buffer-file-name
                                                  load-file-name)))))
(setq auto-insert-expansion-alist
      '(("(>>>DIR<<<)" . (file-name-directory buffer-file-name))
        ("(>>>FILE<<<)" . (file-name-nondirectory buffer-file-name))
        ("(>>>FILE_SANS<<<)" . (file-name-sans-extension
                                (file-name-nondirectory buffer-file-name)))
        ("(>>>FILE_UPCASE<<<)" . (upcase
                                  (file-name-sans-extension
                                   (file-name-nondirectory buffer-file-name))))
        ("(>>>FILE_UPCASE_INIT<<<)" . (upcase-initials
                                       (file-name-sans-extension
                                        (file-name-nondirectory buffer-file-name))))
        ("(>>>FILE_EXT<<<)" . (file-name-extension buffer-file-name))
        ("(>>>FILE_EXT_UPCASE<<<)" . (upcase (file-name-extension buffer-file-name)))
        ("(>>>DATE<<<)" . (format-time-string "%d %b %Y"))
        ("(>>>TIME<<<)" . (format-time-string "%T"))
        ("(>>>VC_DATE<<<)" . (let ((ret ""))
                               (set-time-zone-rule "UTC")
                               (setq ret (format-time-string "%Y/%m/%d %T"))
                               (set-time-zone-rule nil)
                               ret))
        ("(>>>YEAR<<<)" . (format-time-string "%Y"))
        ("(>>>ISO_DATE<<<)" . (format-time-string "%Y-%m-%d"))
        ("(>>>AUTHOR<<<)" . (or user-mail-address
                                (and (fboundp 'user-mail-address)
                                     (user-mail-address))
                                (concat (user-login-name) "@" (system-name))))
        ("(>>>USER_NAME<<<)" . (or (and (boundp 'user-full-name)
                                        user-full-name)
                                   (user-full-name)))
        ("(>>>LOGIN_NAME<<<)" . (user-login-name))
        ("(>>>HOST_ADDR<<<)" . (or (and (boundp 'mail-host-address)
                                        (stringp mail-host-address)
                                        mail-host-address)
                                   (system-name)))))
(defun auto-insert-expand ()
  (dolist (val auto-insert-expansion-alist)
    (let ((from (car val))
          (to (eval (cdr val))))
      (goto-char (point-min))
      (replace-string from to))))
(define-auto-insert "\\.\\([Hh]\\|hh\\|hpp\\)\\'"
  ["h.tpl" auto-insert-expand])
(define-auto-insert "\\.\\([Cc]\\|cc\\|cpp\\)\\'"
  ["cpp.tpl" auto-insert-expand])
(define-auto-insert "\\.java\\'"
  ["java.tpl" auto-insert-expand])
(define-auto-insert "\\.py\\'"
  ["py.tpl" auto-insert-expand])

;;set-buffer-file-coding-system 可以把^M^L等字符转换为unix格式
(provide 'prog-setting)
