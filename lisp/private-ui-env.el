(setq user-full-name "zhang_yunlu")
(setq user-mail-address "luckyzhylu@163.com")
(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8)

(when (string-equal system-type "darwin") ;; macos
  (let (
        (mypaths '(
                   "/Users/zhangyunlu/bin"
                   "/usr/local/bin"
                   "/usr/bin"
                   "/bin"
                   "/usr/sbin"
                   "/sbin"
                   "/usr/local/Cellar/coreutils/8.24/libexec/gnubin/"
                   ))
        )

    ;; 设置 PATH, emacs 的shell使用
    (setenv "PATH" (mapconcat 'identity mypaths ":"))
    ;; 设置exec-path, emacs自身运行是,需要使用(grep,ag,find等)命令时到这些目录去查找
    (setq exec-path (append mypaths (list "." exec-directory)))
    )
  )

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

;; keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)

;; save/restore opened files
(desktop-save-mode 1)

(progn
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  ;; make tab key always call a indent command.
  (setq-default tab-always-indent t)

  ;; make tab key call indent command or insert tab character, depending on cursor position
  ;; (setq-default tab-always-indent nil)

  ;; make tab key do indent first then completion.
  ;; (setq-default tab-always-indent 'complete)  (setq-default tab-always-indent t)
  ;; (setq-default tab-always-indent nil)
  )

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
;; (load-theme 'doom-nord-light t)  ;; ok
;; (load-theme 'doom-opera-light t) ;; ok
;; (load-theme 'doom-solarized-light t)
;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; or for treemacs users
;; (doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)
(if (ido-mode t)
    (progn (setq ido-max-window-height 20)
           (setq max-mini-window-height 5))) ;; 不能实现赋值,zhangyunlu

;; (when (require 'undo-tree)
;; (global-undo-tree-mode))

(require 'hungry-delete)
(global-hungry-delete-mode t)

;; 自动保存bookmark,emacs退出自动保存bookmark
;; (setq bookmark-save-flag 1) ; everytime bookmark is changed, automatically save it
(setq bookmark-save-flag t) ; save bookmark when emacs quits

;; Set Emacs to Open Bookmark File on Start
;; (setq inhibit-splash-screen t)
;; (require 'bookmark)
;; (bookmark-bmenu-list)
;; (switch-to-buffer "*Bookmark List*")

(defun change-default-directory()
  "change default-directory by user input"
  (interactive)
  (setq default-directory (read-directory-name "Entry default directory:" nil)))
;; (global-set-key [f1] 'change-default-directory)

(require 'browse-kill-ring)
(global-set-key "\C-cy" 'browse-kill-ring)

(defun xah-pop-local-mark-ring ()
  "Move cursor to last mark position of current buffer.
Call this repeatedly will cycle all positions in `mark-ring'.
URL `http://ergoemacs.org/emacs/emacs_jump_to_previous_position.html'
Version 2016-04-04"
  (interactive)
  (set-mark-command t))
(global-set-key (kbd "<f1>") 'xah-pop-local-mark-ring)
(global-set-key (kbd "<f2>") 'pop-global-mark)
(global-set-key (kbd "\C-cm") 'set-mark-command) ;; set mark,define by zhangyunlu


(setq mark-ring-max 6)
(setq global-mark-ring-max 16)

(electric-pair-mode 1) ;; auto insert closing bracket,自动插入右括号

;; make cursor movement stop in between camelCase words.
;; (global-subword-mode 1) ;; 光标在大小写之间停住

;;(require 'highlight-tail)     ;; 非常炫的插件
;;(highlight-tail-mode t)

;; (when (require 'highlight-symbol)
;;   (global-set-key (kbd "C-c g d") 'highlight-symbol-at-point)
;;   (global-set-key (kbd "s-j") 'highlight-symbol-next)
;;   (global-set-key (kbd "s-k") 'highlight-symbol-prev)
;;   ;; (global-set-key [(control meta f3)] 'highlight-symbol-query-replace)
;;   )

;;(require 'rainbow-mode) ;; 暂时没有明白效果是怎么样的

(when (require 'recent-jump)
  (setq recent-jump-threshold 4)
  (setq recent-jump-ring-length 10)
  (global-set-key (kbd "C-o") 'recent-jump-jump-backward)
  (global-set-key (kbd "M-o") 'recent-jump-jump-forward)
  )

;;(when(require 'volatile-highlights) ;; 没有明白有什么作用
;; (volatile-highlights-mode t))

(provide 'private-ui-env)
