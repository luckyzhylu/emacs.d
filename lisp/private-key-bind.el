(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun xah-beginning-of-line-or-block ()
  "Move cursor to beginning of line or previous paragraph.

• When called first time, move cursor to beginning of char in current line. (if already, move to beginning of line.)
• When called again, move cursor backward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2017-05-13"
  (interactive)
  (let (($p (point)))
    (if (or (equal (point) (line-beginning-position))
            (equal last-command this-command ))
        (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
            (progn
              (skip-chars-backward "\n\t ")
              (forward-char ))
          (goto-char (point-min)))
      (progn
        (back-to-indentation)
        (when (eq $p (point))
          (beginning-of-line))))))

(defun xah-end-of-line-or-block ()
  "Move cursor to end of line or next paragraph.

• When called first time, move cursor to end of line.
• When called again, move cursor forward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2017-05-30"
  (interactive)
  (if (or (equal (point) (line-end-position))
          (equal last-command this-command ))
      (progn
        (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" ))
    (end-of-line)))
(global-set-key (kbd "C-a") 'xah-beginning-of-line-or-block)
(global-set-key (kbd "C-e") 'xah-end-of-line-or-block)




;; (defvar xah-brackets nil "string of left/right brackets pairs.")
;; (setq xah-brackets "()[]{}<>（）［］｛｝⦅⦆〚〛⦃⦄“”‘’‹›«»「」〈〉《》【】〔〕⦗⦘『』〖〗〘〙｢｣⟦⟧⟨⟩⟪⟫⟮⟯⟬⟭⌈⌉⌊⌋⦇⦈⦉⦊❛❜❝❞❨❩❪❫❴❵❬❭❮❯❰❱❲❳〈〉⦑⦒⧼⧽﹙﹚﹛﹜﹝﹞⁽⁾₍₎⦋⦌⦍⦎⦏⦐⁅⁆⸢⸣⸤⸥⟅⟆⦓⦔⦕⦖⸦⸧⸨⸩｟｠⧘⧙⧚⧛⸜⸝⸌⸍⸂⸃⸄⸅⸉⸊᚛᚜༺༻༼༽⏜⏝⎴⎵⏞⏟⏠⏡﹁﹂﹃﹄︹︺︻︼︗︘︿﹀︽︾﹇﹈︷︸")

;; (defvar xah-left-brackets '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«" )
;;   "List of left bracket chars.")
;; (progn
;;   ;; make xah-left-brackets based on xah-brackets
;;   (setq xah-left-brackets '())
;;   (dotimes ($x (- (length xah-brackets) 1))
;;     (when (= (% $x 2) 0)
;;       (push (char-to-string (elt xah-brackets $x))
;;             xah-left-brackets)))
;;   (setq xah-left-brackets (reverse xah-left-brackets)))

;; (defvar xah-right-brackets '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»")
;;   "list of right bracket chars.")
;; (progn
;;   (setq xah-right-brackets '())
;;   (dotimes ($x (- (length xah-brackets) 1))
;;     (when (= (% $x 2) 1)
;;       (push (char-to-string (elt xah-brackets $x))
;;             xah-right-brackets)))
;;   (setq xah-right-brackets (reverse xah-right-brackets)))

;; (defun xah-backward-left-bracket ()
;;   "Move cursor to the previous occurrence of left bracket.
;; The list of brackets to jump to is defined by `xah-left-brackets'.
;; URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
;; Version 2015-10-01"
;;   (interactive)
;;   (re-search-backward (regexp-opt xah-left-brackets) nil t))

;; (defun xah-forward-right-bracket ()
;;   "Move cursor to the next occurrence of right bracket.
;; The list of brackets to jump to is defined by `xah-right-brackets'.
;; URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
;; Version 2015-10-01"
;;   (interactive)
;;   (re-search-forward (regexp-opt xah-right-brackets) nil t))

;; (global-set-key (kbd "C-c p") 'xah-backward-left-bracket)
;; (global-set-key (kbd "C-c n") 'xah-backward-right-bracket)

;; (defun xah-goto-matching-bracket ()
;;   "Move cursor to the matching bracket.
;; If cursor is not on a bracket, call `backward-up-list'.
;; The list of brackets to jump to is defined by `xah-left-brackets' and `xah-right-brackets'.
;; URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
;; Version 2016-11-22"
;;   (interactive)
;;   (if (nth 3 (syntax-ppss))
;;       (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
;;     (cond
;;      ((eq (char-after) ?\") (forward-sexp))
;;      ((eq (char-before) ?\") (backward-sexp ))
;;      ((looking-at (regexp-opt xah-left-brackets))
;;       (forward-sexp))
;;      ((looking-back (regexp-opt xah-right-brackets) (max (- (point) 1) 1))
;;       (backward-sexp))
;;      (t (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)))))
;; ;; (global-set-key (kbd "C-c m") 'xah-goto-matching-bracket)
;; (global-set-key (kbd "s-m") 'xah-goto-matching-bracket)

(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode)
  )

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)


;; swiper key bind
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)  

(provide 'private-key-bind)
