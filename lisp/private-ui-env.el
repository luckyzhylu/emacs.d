(setq user-full-name "zhang_yunlu")
(setq user-mail-address "luckyzhylu@163.com")

(setenv "PATH" (concat "/Users/zhangyunlu/bin:/usr/local/bin:/usr/local/Cellar/coreutils/8.24/libexec/gnubin/:" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/bin/")))

;; load slime-2.22
(add-to-list 'load-path "/usr/local/bin/slime-2.22/") ;;这是SLIME的目录，下面有各种LISP方言的.el文件，包括SBCL和CLISP的
(setq inferior-lisp-program "/usr/local/bin/sbcl") ;;指明用的Lisp的可执行文件
(require 'slime-autoloads)
(slime-setup '(slime-fancy)) ;;如果不加'(slime-fancy)，slime的所有加载信息都会显示出来

;; 设置默认的窗口大小
(setq default-frame-alist
      '((height . 60) (width . 160) (menu-bar-lines . 20) (tool-bar-lines . 0)))
(tool-bar-mode 0)
;; (menu-bar-mode 0)
(scroll-bar-mode 1)

(setq inhibit-startup-message t) ;; 关闭emacs启动画面
(global-hl-line-mode 1)  ;; 高亮当前行
(global-linum-mode t) ;; 显示行号
(column-number-mode t) ;; 显示列数
(line-number-mode t)  ;; 显示行数
(setq-default cursor-type 'bar);; 光标为为竖线，不是原来的方块
(setq make-backup-files nil)

;;(load-theme 'solarized t)
(add-hook 'after-make-frame-functions
  (lambda (frame)
    (let ((mode (if (display-graphic-p frame) 'light 'dark)))
       (set-frame-parameter frame 'background-mode mode)
       (set-terminal-parameter frame 'background-mode mode))
       (enable-theme 'solarized)))

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
;; (load-theme 'doom-one t)
;; (load-theme 'doom-city-lights t)
;; (load-theme 'doom-opera-light t)
;; (load-theme 'doom-nova t)
;; (load-theme 'doom-spacegrey t)
;; (load-theme 'doom-tomorrow-day t)
;; (load-theme 'doom-tomorrow-night t)
;; (load-theme 'doom-molokai t)
(load-theme 'doom-nord-light t)  ;; ok
;; (load-theme 'doom-opera-light t) ;; ok
(load-theme 'doom-solarized-light t)
;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
(if (ido-mode t)
  (progn (setq ido-max-window-height 20)
	 (setq max-mini-window-height 5))) ;; 不能实现赋值,zhangyunlu

;; (when (require 'undo-tree)
;; (global-undo-tree-mode))

(defun change-default-directory()
  "change default-directory by user input"
  (interactive)
  (setq default-directory (read-directory-name "Entry default directory:" nil)))
(global-set-key [f1] 'change-default-directory)

(require 'browse-kill-ring)
(global-set-key "\C-cy" 'browse-kill-ring)

(provide 'private-ui-env)
