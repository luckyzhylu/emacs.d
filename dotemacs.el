
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/gnu/") t)
(add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa-stable/")t)


;; (custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(package-selected-packages
;;   (quote
;;    (pallet package-build shut-up epl git commander f dash s company))))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-paren-colors
   (quote
    ("dark red" "dark blue" "dark magenta" "light green")))
 '(package-selected-packages (quote (molokai-theme undo-tree ggtags yasnippet company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(tool-bar-mode 0)
;; (add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-doom-themes/")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-color-theme-solarized")

(require 'private-ui-env)
(require 'prog-setting)
(require 'private-key-bind)


