
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'private-package)
(require 'private-env)
(require 'private-ui)
(require 'prog-setting)


(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

;; 暂时还不知道怎么使用
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; bm配置
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "C-c m") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
;; (global-set-key (kbd "<f1>")   'bm-cycle-all-buffers)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "C-c b") 'helm-bm)

(require 'ranger)
(ranger-override-dired-mode t)


;; (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)

;; (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
;; (setq bm-marker 'bm-marker-left)


(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)
(use-package goto-chg
  :init
  :config
  :bind
  ("C-." . 'goto-last-change)
  ("C-c ." . 'goto-last-change)
  ("C-," . 'goto-last-change-reverse)
  ("C-c ," . 'goto-last-change-reverse)
  )


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


;; org-mode模式下，显示各类语言的语法高亮
;; (require 'org-mode)
(setq org-src-fontify-natively t)

(require 'browse-kill-ring)
(auto-highlight-symbol-mode t)
(global-set-key (kbd "C-c y") 'browse-kill-ring)

(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode)
  )


;; (require 'projectile)
;; 默认全局使用
;; (projectile-global-mode)
;; 默认打开缓存
;; (setq projectile-enable-caching t)
;; 使用f5键打开默认文件搜索
;; (global-set-key [f5] 'projectile-find-file)

(use-package projectile
  :init
  :config
  (progn
    (setq projectile-enable-caching t)
    (projectile-global-mode t)
    )
  :bind
  ([f5] . 'projectile-find-file)
  ()
  )
(projectile-mode t)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
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

(add-hook 'after-init-hook 'global-company-mode)
;; (global-company-mode t)
(global-hungry-delete-mode t)

(use-package doxymacs
  :init
  :config
  (add-hook 'c-mode-common-hook 'doxymacs-mode)
  )

(use-package xcscope
  :init
  :config
  (cscope-setup))

;; https://github.com/joaotavora/yasnippet
;;~/.emacs.d/snippets
(use-package yasnippet
  :config
  (yas-global-mode t))


;; 显示空白字符,删除末尾的空白字符
;; (global-whitespace-mode t)
;; (delete-trailing-whitespace)

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
(global-set-key (kbd "C-c ;") 'avy-goto-char)
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

(require 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

;; C/C++代码风格设置
(which-function-mode)
;; (require 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

(use-package google-c-style
  :init
  (setq-default tab-width 4)
  (setq c-default-style "linux")
  (setq-default c-basic-offset 4)
  :config
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  :bind)
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


(require 'smart-hungry-delete)
(smart-hungry-delete-add-default-hooks)
(global-set-key (kbd "<backspace>") 'smart-hungry-delete-backward-char)
(global-set-key (kbd "C-d") 'smart-hungry-delete-forward-char)
(global-set-key (kbd "s-<backspace>") 'hungry-delete-backward)

;; 指定major-mode
;; (setq auto-mode-alist
;;     (append '(("emacs-init-[0-9]*\\'“ . lisp-mode))
;;     auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))



;; (require 'dired+)

;; emacs定制的变量放到my-custome.el中,每次启动后加载my-custom.el
(setq custom-file (expand-file-name "lisp/my-custom.el" user-emacs-directory))
(load-file custom-file)
(require 'prog-setting)

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun open-workspace()
  (interactive)
  (let ((filename (read-directory-name "open project:")))
    (setq my-dirname (f-dirname filename))
    (message "%s:%s" my-dirname filename)
    (loop for x in (read-lines filename) do
          (find-file (concat my-dirname "/" x)))
    )
  )

;; (unbind-key "C-c ." c-mode-map)
;; (unbind-key "C-c ," c-mode-map)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-g") 'goto-line)

(window-numbering-mode t)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
