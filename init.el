(setq user-full-name "zhang_yunlu")
(setq user-mail-address "luckyzhylu@163.com")

;; 设置emacs的路径与exec-path-from-shell效果是一样的
;; (when (string-equal system-type "darwin") ;; macos
;;   (let (
;;         (mypaths '(
;;                    "/Users/zhangyunlu/bin"
;;                    "/usr/local/bin"
;;                    "/usr/bin"
;;                    "/bin"
;;                    "/usr/sbin"
;;                    "/sbin"
;;                    "/usr/local/Cellar/coreutils/8.24/libexec/gnubin/"
;;                    ))  
;;         )   

;;   ;; 设置 PATH, emacs 的shell使用
;;   (setenv "PATH" (mapconcat 'identity mypaths ":"))
;;   ;; 设置exec-path, emacs自身运行是,需要使用(grep,ag,find等)命令时到这些目录去查找
;;   (setq exec-path (append mypaths (list "." exec-directory)))
;;   )   
;; )


(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '(
                 "melpa" . "http://melpa.org/packages/"
                 ) t)
  )

;; customize-group可以用于自定义插件的功能

;; MACOS系统指定PATH，这样emacs能做到对应的可执行程序
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  )
(require 'cl)

(defvar zyl/packages '(
                       auto-highlight-symbol
                       highlight-symbol
                       smex
                       dsvn
                       google-c-style
                       undo-tree
               smartparens
               use-package
               ace-jump-mode
               highlight-parentheses
               yasnippet
               undo-tree
               monokai-theme
               company
               helm-projectile
               ivy
               counsel
               swiper
               ace-window
               magit
               aggressive-indent
               hungry-delete
               ggtags
               exec-path-from-shell
               rainbow-delimiters
               fill-column-indicator
               browse-kill-ring
               bm
               helm-cscope
               xcscope
               yatemplate
               popwin
               window-numbering
               expand-region
               clang-format
                       )
  "Default packages" )

(setq package-selected-packages zyl/packages)

(defun zyl/packages-installed-p()
  (setq load-prefer-newer t) ;;每次载入最新的版本
  (loop for pkg in zyl/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (zyl/packages-installed-p)
  ;; (message "%s" "refreshing package database ...")
  (package-refresh-contents)
  (dolist (pkg zyl/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(load-theme 'monokai t)


;; 设置默认的窗口大小
;; (setq default-frame-alist '((height . 60) (width . 160) (menu-bar-lines . 20) (tool-bar-lines . 0)))
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(tool-bar-mode 0)
;; (menu-bar-mode 0)
(scroll-bar-mode 1)

(setq inhibit-startup-message t) ;; 关闭emacs启动画面
(save-place-mode 1)  ;; remember cursor position
(setq make-backup-files nil) ;; stop creating those backup~ files
(global-hl-line-mode 1)  ;; 高亮当前行
(global-linum-mode t) ;; 显示行号
(column-number-mode t) ;; 显示列数
(line-number-mode t)  ;; 显示行数
(setq-default cursor-type 'bar);; 光标为为竖线，不是原来的方块
(setq make-backup-files nil)
;; when a file is updated outside emacs, make it update if it's already opened in emacs
(global-auto-revert-mode t) ;; 自动更新被变更的文件
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; make tab key always call a indent command.
(setq-default tab-always-indent t)

(if (ido-mode t)
    (progn (setq ido-max-window-height 20)
           (setq max-mini-window-height 5))) ;; 不能实现赋值,zhangyunlu

;; 选择区域,输入后直接覆盖
(delete-selection-mode t)

;; org-mode模式下，显示各类语言的语法高亮
;; (require 'org-mode)
(setq org-src-fontify-natively t)

(require 'browse-kill-ring)


(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode)
  )

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; swiper key bind
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;; 设置emacs字体
(set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

(add-hook 'after-init-hook 'global-company-mode)
;; (global-company-mode t)
(global-hungry-delete-mode t)

;; 显示空白字符,删除末尾的空白字符
(global-whitespace-mode t)
(delete-trailing-whitespace)


;; 括号彩虹色
(rainbow-delimiters-mode-enable)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'popwin)
(popwin-mode 1)
;; (global-set-key (kbd "C-z") popwin:keymap)

(require 'avy)
(global-set-key (kbd "C-;") 'avy-goto-char)

;; Enable window-numbering-mode and use M-1 through M-0 to navigate
(window-numbering-mode t)

;;
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; 括号配对插入
(use-package smartparens
  :defer 1
  :commands (sp-pair sp-local-pairs)
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil
    sp-highlight-wrap-overlay nil
    sp-highlight-wrap-tag-overlay nil
    sp-show-pair-from-inside t
    sp-cancel-autoskip-on-backward-movement nil
    sp-show-pair-delay 0.1
    sp-max-pair-length 4
    sp-max-prefix-length 50
    sp-escape-quotes-after-insert nil)
  (smartparens-global-mode +1)
  )


;; (require 'ivy)
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;; (add-to-list'package-archives '("melpa-stable" . "https://stable.melpa.org/packages")t)xe

;; (add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/gnu/") t)
;; (add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa-stable/")t)


;; 指定major-mode
;; (setq auto-mode-alist
;;     (append '(("emacs-init-[0-9]*\\'“ . lisp-mode))
;;     auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))


;; (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
;; (cask-initialize)

;; UTF-8作为默认的编码方式
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8)


(defvar mage-init-time 'nil)
(defun mage-display-benchmark()
  (message "Mage loaded %s packages in %.03fs"
           (length package-activated-list)
           (or mage-init-time
               (setq mage-init-time
                     (float-time (time-subtract (current-time) before-init-time))))))
(add-hook 'emacs-startup-hook #'mage-display-benchmark)
