(setq user-full-name "zhang_yunlu")
(setq user-mail-address "luckyzhylu@163.com")

;; (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)


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

(add-to-list 'load-path "~/.emacs.d/lisp")

;; use cask and pallet manage packages
;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (package-initialize)
;;   (add-to-list 'package-archives
;;                '(
;;                  "melpa" . "http://melpa.org/packages/"
;;                  ) t)
;;   )

;; ;; customize-group可以用于自定义插件的功能
;; (require 'cl)

;; (defvar zyl/packages '(
;;                        hydra
;;                        pallet
;;                        ivy-hydra
;;                        move-text
;;                        helm-projectile
;;                        ivy
;;                        counsel
;;                        swiper
;;                        ace-window
;;                        magit
;;                        aggressive-indent
;;                        hungry-delete
;;                        ggtags
;;                        exec-path-from-shell
;;                        rainbow-delimiters
;;                        fill-column-indicator
;;                        browse-kill-ring
;;                        bm
;;                        helm-bm
;;                        helm-cscope
;;                        xcscope
;;                        yatemplate
;;                        popwin
;;                        window-numbering
;;                        expand-region
;;                        clang-format
;;                        )
;;   "Default packages" )

;; (setq package-selected-packages zyl/packages)

;; (defun zyl/packages-installed-p()
;;   (setq load-prefer-newer t) ;;每次载入最新的版本
;;   (loop for pkg in zyl/packages
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))

;; (unless (zyl/packages-installed-p)
;;   ;; (message "%s" "refreshing package database ...")
;;   (package-refresh-contents)
;;   (dolist (pkg zyl/packages)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))



;; MACOS系统指定PATH，这样emacs能做到对应的可执行程序
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  )

(load-theme 'monokai t)

(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

;; 暂时还不知道怎么使用
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c b") 'helm-bm)


(require 'ranger)
(ranger-override-dired-mode t)


;; dired mode文件夹直接拷贝和删除,不询问
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; dired mode重用缓冲区
(put 'dired-find-alternate-file 'disabled nil)
;; 延迟加载
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
;; (setq bm-marker 'bm-marker-left)


(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

;; 设置默认的窗口大小
;; (setq default-frame-alist '((height . 60) (width . 160) (menu-bar-lines . 20) (tool-bar-lines . 0)))
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(tool-bar-mode 0)
;; (menu-bar-mode 0)
;;(scroll-bar-mode 1)

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

;; (require 'ivy)
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(setq-default make-backup-files nil)
;;hydra增强按键绑定
(require 'hydra)
(require 'ivy-hydra)
(defhydra hydra-zoom (global-map "<esc>")
      "zoom"
      ("g" text-scale-increase "in")
      ("l" text-scale-decrease "out"))

(with-eval-after-load 'ivy
(define-key ivy-minibuffer-map "\C-c"
  (defhydra soo-ivy (:hint nil :color pink)
    ;; arrows
    ("j" ivy-next-line)
    ("k" ivy-previous-line)
    ("l" ivy-alt-done)
    ("h" ivy-backward-delete-char)
    ("g" ivy-beginning-of-buffer)
    ("G" ivy-end-of-buffer)
    ("d" ivy-scroll-up-command)
    ("u" ivy-scroll-down-command)
    ("e" ivy-scroll-down-command)
    ;; actions
    ("q" keyboard-escape-quit :exit t)
    ("C-g" keyboard-escape-quit :exit t)
    ("<escape>" keyboard-escape-quit :exit t)
    ("C-o" nil)
    ("i" nil)
    ("TAB" ivy-alt-done :exit nil)
    ("C-j" ivy-alt-done :exit nil)
    ;; ("d" ivy-done :exit t)
    ("RET" ivy-done :exit t)
    ("C-m" ivy-done :exit t)
    ("f" ivy-call)
    ("c" ivy-toggle-calling)
    ("m" ivy-toggle-fuzzy)
    (">" ivy-minibuffer-grow)
    ("<" ivy-minibuffer-shrink)
    ("w" ivy-prev-action)
    ("s" ivy-next-action)
    ("a" ivy-read-action)
    ("t" (setq truncate-lines (not truncate-lines)))
    ("C" ivy-toggle-case-fold)
    ("o" ivy-occur :exit t))))



(require 'flx-ido)
(ido-everywhere 1)
(flx-ido-mode 1)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; 选择区域,输入后直接覆盖
(delete-selection-mode t)

;; org-mode模式下，显示各类语言的语法高亮
;; (require 'org-mode)
(setq org-src-fontify-natively t)

(require 'browse-kill-ring)
(auto-highlight-symbol-mode t)
(global-set-key (kbd "C-c y") 'browse-kill-ring)

(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode)
  )


(require 'projectile)
;; 默认全局使用
(projectile-global-mode)
;; 默认打开缓存
(setq projectile-enable-caching t)
;; 使用f5键打开默认文件搜索
(global-set-key [f5] 'projectile-find-file)

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; swiper key bind
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)

;; 查找在git版本下的文件
(global-set-key (kbd "C-c g f") 'counsel-git)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;; 设置emacs字体
(set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

(add-hook 'after-init-hook 'global-company-mode)
;; (global-company-mode t)
(global-hungry-delete-mode t)

(require 'xcscope)
(cscope-setup)

;; https://github.com/joaotavora/yasnippet
;;~/.emacs.d/snippets
(require 'yasnippet)
(yas-global-mode 1)

;; 显示空白字符,删除末尾的空白字符
(global-whitespace-mode t)
(delete-trailing-whitespace)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
                                            ("zyl" "zhangyunlu")

                                            ))

;; 括号彩虹色
(rainbow-delimiters-mode-enable)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'popwin)
(popwin-mode 1)
;; (global-set-key (kbd "C-z") popwin:keymap)

(require 'avy)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-c l") 'avy-goto-line)

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


;; C/C++代码风格设置
(which-function-mode)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq c-default-style "linux")
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;;打开代码折叠功能
;; (add-hook 'c-mode-common-hook
;;           (lambda() '((progn
;;                      ;;在模式栏中显示当前光标所在函数
;;                         (which-function-mode)
;;                         (ggtags-mode t)
;;                         (hs-minor-mode)))))

;; (add-hook 'prog-mode-hook (lambda() (ggtags-mode t)))
(add-hook 'c-mode-common-hook (lambda() (progn
                                          (ggtags-mode t)
                                          (fci-mode t)
                                          (setq fci-rule-column 80)
                                          )))

(add-hook 'c-mode-common-hook 'helm-cscope-mode)
(add-hook 'helm-cscope-mode-hook
          (lambda ()
            ;; 暂时还使用global来定位,cscope有可能会没有cscope的数据库文件
            ;; (local-set-key (kbd "M-.") 'helm-cscope-find-global-definition)
            (local-set-key (kbd "M-@") 'helm-cscope-find-calling-this-function)
            (local-set-key (kbd "M-s") 'helm-cscope-find-this-symbol)
            (local-set-key (kbd "M-c") 'helm-cscope-find-called-function)
            (local-set-key (kbd "M-,") 'helm-cscope-pop-mark)))

;; (when (or (fboundp 'c-mode) (fboundp 'c++-mode)
;;           (ggtags-mode t)
;;           )
;; (setq-default c-basic-offset 4)
;;自动的在文件末增加一新行
;; (setq require-final-newline t)


;; 光标在括号内时就高亮包含内容的两个括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
         (ignore-errors (backward-up-list))
         (funcall fn)))))

;; 可以使鼠标在括号上是高亮其所匹配的另一半括号
(show-paren-mode t)


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

;; (add-to-list'package-archives '("melpa-stable" . "https://stable.melpa.org/packages")t)xe

;; (add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/gnu/") t)
;; (add-to-list'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa-stable/")t)


;; 指定major-mode
;; (setq auto-mode-alist
;;     (append '(("emacs-init-[0-9]*\\'“ . lisp-mode))
;;     auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

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

;; emacs定制的变量放到my-custome.el中,每次启动后加载my-custom.el
(setq custom-file (expand-file-name "lisp/my-custom.el" user-emacs-directory))
(load-file custom-file)
