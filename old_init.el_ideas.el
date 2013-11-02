
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))


(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)

;; Line wrap with soft indent

(defun srb-adaptive-indent (beg end)
  "Indent the region between BEG and END with adaptive filling."
  (goto-char beg)
  (while
      (let ((lbp (line-beginning-position))
            (lep (line-end-position)))
        (put-text-property lbp lep 'wrap-prefix (fill-context-prefix lbp lep))
        (search-forward "\n" end t))))

(define-minor-mode srb-adaptive-wrap-mode
  "Wrap the buffer text with adaptive filling."
  :lighter ""
  (save-excursion
    (save-restriction
      (widen)
      (let ((buffer-undo-list t)
            (inhibit-read-only t)
            (mod (buffer-modified-p)))
        (if srb-adaptive-wrap-mode
            (progn
              (setq word-wrap t)
              (unless (member '(continuation) fringe-indicator-alist)
                (push '(continuation) fringe-indicator-alist))
              (jit-lock-register 'srb-adaptive-indent))
          (jit-lock-unregister 'srb-adaptive-indent)
          (remove-text-properties (point-min) (point-max) '(wrap-prefix pref))
          (setq fringe-indicator-alist
                (delete '(continuation) fringe-indicator-alist))
          (setq word-wrap nil))
        (restore-buffer-modified-p mod)))))

; (require 'anything)

;

(when (require 'lusty-explorer nil 'noerror)
  ;; overrride the normal file-opening, buffer switching
  (global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
  (global-set-key (kbd "C-x C-b")   'lusty-buffer-explorer)
  (global-set-key (kbd "C-x b")   'lusty-buffer-explorer))
