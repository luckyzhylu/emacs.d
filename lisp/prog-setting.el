(add-hook 'after-init-hook 'global-company-mode)
;; (require 'highlight-parentheses)
;; (define-globalized-minor-mode global-highlight-parentheses-mode
;;   highlight-parentheses-mode
;;   (lambda ()
;;     (highlight-parentheses-mode t)
;;     (show-paren-mode t)))
;; (global-highlight-parentheses-mode t)

(defun my-whitespace-mode()
  (progn
    ;; Make whitespace-mode with very basic background coloring for whitespaces.
    ;; http://ergoemacs.org/emacs/whitespace-mode.html

    (global-whitespace-mode t)
    (delete-trailing-whitespace)
    (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

    ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
    (setq whitespace-display-mappings
          ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
          '(
            (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
            (newline-mark 10 [182 10]) ; LINE FEED,
            (tab-mark 9 [9655 9] [92 9]) ; tab
            ))
    )
  )

(my-whitespace-mode)

;; (require 'indent-guide)
;; (indent-guide-global-mode t)         ;; 对齐线,用处不大,容易产生干扰
;; (global-aggressive-indent-mode t)    ;; 很不好用的插件

;;(set-face-background 'indent-guide-face "dimgray")
;; (setq indent-guide-char ":")


(defun my-private-program-hook()
  (when (derived-mode-p 'c-mode 'c++-mode)
    (yas-global-mode 1)
    (ggtags-mode 1))

  (when(require 'fill-column-indicator)
    (fci-mode t)
    (setq fci-rule-column 80)
    )
  (when (require 'ifdef)
    (global-set-key (kbd "C-c C-i") 'mark-ifdef)

    (add-hook 'before-save-hook '
              (lambda()
                ;; (whitespace-cleanup t)  ;; 清理空白字符,导致光标移动出错
                (delete-trailing-lines)  ;; 删除空白行
                (delete-trailing-whitespace) ;; 删除空白字符
                ))
    )


  (electric-indent-mode 1) ;; make return key also do indent, globally
  (when (require 'doxymacs nil 'noerror)
    (doxymacs-mode t)
    (doxymacs-font-lock))
  ;; (when (require 'sourcepari nil 'noerror)
  ;;   (setq sourcepair-source-extensions
  ;;         '(".cpp" ".cxx" ".c++" ".CC" ".cc" ".C" ".c" ".mm" ".m"))
  ;;   (setq sourcepair-header-extensions
  ;;         '(".hpp" ".hxx" ".h++" ".HH" ".hh" ".H" ".h"))
  ;;   (setq sourcepair-header-path '("." "include" ".." "../include" "../inc"
  ;;                                  "../../include" "../../inc" "../*"))
  ;;   (setq sourcepair-source-path '("." "src" ".." "../src" "../*"))
  ;;   (setq sourcepair-recurse-ignore '("CVS" ".svn" ".hg" ".git" ".bzr"
  ;;                                     "Obj" "Debug" "Release" "bin" "lib"))
  ;;   (define-key c-mode-base-map (kdb "esc <f12>") 'sourcepair-load)
  ;;   (define-key c-mode-base-map [f12] 'sourcepair-load))
  ;;
  )
(add-hook 'c-mode-common-hook 'my-private-program-hook)

(define-key global-map "\C-xz" 'sourcepair-load)

;; cscope
(when (executable-find "cscope")
  (when (require 'xcscope nil 'noerror)
    (define-key cscope-list-entry-keymap [mouse-1]
      'cscope-mouse-select-entry-other-window)))
(require 'xcscope)

(setq auto-mode-alist
      (append
       '(("\\.\\(p\\(?:k[bg]\\|ls\\)\\|sql\\)\\'" . plsql-mode))
       auto-mode-alist))
;; (speedbar-add-supported-extension "pls")
;; (speedbar-add-supported-extension "pkg")
;; (speedbar-add-supported-extension "pkb")
;; (speedbar-add-supported-extension "sql")

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

;; ffip, find file in project
(require 'find-file-in-project)
;; (setq ffip-use-rust-fd t)
(defun change-default-directory()
  "change default-directory by user input"
  (interactive)
  (setq ffip-project-root (read-directory-name "Entry default directory:" nil)))
(global-set-key [f1] 'change-default-directory)

(global-set-key (kbd "C-x f") 'find-file-in-project)

;; magit key shortcut
(global-set-key (kbd "C-x g") 'magit-status)

;;set-buffer-file-coding-system 可以把^M^L等字符转换为unix格式
(provide 'prog-setting)
