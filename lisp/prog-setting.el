(add-hook 'after-init-hook 'global-company-mode)
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)
    (show-paren-mode t)))
(global-highlight-parentheses-mode t)


(defun my-private-program-hook()
  (when (derived-mode-p 'c-mode 'c++-mode)
    (yas-global-mode 1)
    (ggtags-mode 1))
  (when (require 'doxymacs nil 'noerror)
    (doxymacs-mode t)
    (doxymacs-font-lock))
  (when (require 'sourcepari nil 'noerror)
    (setq sourcepair-source-extensions
	  '(".cpp" ".cxx" ".c++" ".CC" ".cc" ".C" ".c" ".mm" ".m"))
    (setq sourcepair-header-extensions
	  '(".hpp" ".hxx" ".h++" ".HH" ".hh" ".H" ".h"))
    (setq sourcepair-header-path '("." "include" ".." "../include" "../inc"
				   "../../include" "../../inc" "../*"))
    (setq sourcepair-source-path '("." "src" ".." "../src" "../*"))
    (setq sourcepair-recurse-ignore '("CVS" ".svn" ".hg" ".git" ".bzr"
				      "Obj" "Debug" "Release" "bin" "lib"))
    (define-key c-mode-base-map (kdb "esc <f12>") 'sourcepair-load)
    (define-key c-mode-base-map [f12] 'sourcepair-load))
)
(add-hook 'c-mode-common-hook 'my-private-program-hook)

(define-key global-map "\C-xz" 'sourcepair-load)

(provide 'prog-setting)
