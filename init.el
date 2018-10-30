(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; (add-to-list'package-archives '("melpa-stable" . "https://stable.melpa.org/packages")t)xe

;; (add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/gnu/") t)
(add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa-stable/")t)

(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

