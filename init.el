;; Emacs Configuration File.
;;
;; Authored by Carl Hu 2012
;; Copyright 2012 Carl Hu
;;
;; This program is distributed under the terms of the GNU General Public License.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see http://www.gnu.org/licenses.

(require 'cl)

(message "My init file is completely loaded.")

(delete-selection-mode t)
;;; (winner-mode t)
(setq global-auto-revert-non-file-buffers t)
(setq revert-without-query (quote (".*")))
(fringe-mode 'none)
(modify-frame-parameters (selected-frame) (list (cons 'name "Emacs")))
(setq backup-directory-alist `((".*" . "~/emacs_backup")))
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))
(setq backup-by-copying t)
(setq auto-save-list-file-prefix
      (concat temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms 
      `((".*" , temporary-file-directory t)))
(setq auto-sae-default t)
(setq auto-save-interval 20) ;; keystrokes
;(setq auto-revert-interval 1) 
(setq auto-save-timeout 20) ;; seconds
(require 'saveplace)
(setq-default save-place t)
(setq org-startup-indented t)
(setq org-confirm-babel-evaluate nil)
(setq org-yank-adjusted-subtrees t) ; advanced cut and paste behavior for orgmode points.
(setq org-yank-folded-subtrees t) ; advanced cut and paste behavior for orgmode points.
(setq org-hide-leading-stars t)
(setq org-odd-level-only nil) 
;; configure org
(setq org-insert-heading-respect-content nil)
;; (setq org-M-RET-may-split-line t)
(setq org-M-RET-may-split-line '((item) (default . t)))
;(setq org-M-RET-may-split-line t)
(setq org-special-ctrl-a/e t)
(setq org-return-follows-link nil)
;(setq org-use-speed-commands t)
(setq org-startup-align-all-tables nil)
(setq org-tags-column 0) 
;; (setq org-archive-location (concat org-directory "archive/%s_archive::"))
;; (setq org-agenda-remove-tags t)
;;(setq org-treat-S-cursor-todo-selection-as-state-change t)
(setq org-log-into-drawer nil)
(setq org-ellipsis " \u25ba" )
(setq org-use-speed-commands t)
(setq org-speed-commands-user nil)
(add-to-list 'org-speed-commands-user
             '("n" ded/org-show-next-heading-tidily))
(add-to-list 'org-speed-commands-user
             '("p" ded/org-show-previous-heading-tidily))


;; Fix a problem with saveplace.el putting you back in a folded position:
(add-hook 'org-mode-hook
          (lambda ()
            (when (outline-invisible-p)
              (save-excursion
                (outline-previous-visible-heading 1)
                (org-show-subtree)))))

(add-to-list 'load-path "~/emacs_terminal/")
(add-to-list 'load-path "~/emacs_terminal/emacs-color-theme-solarized/")
(require 'color-theme-solarized)

;; (add-to-list 'load-path "~/emacs.d/color-theme-sanityinc-solarized/")
(require 'color-theme-sanityinc-solarized)

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)

(blink-cursor-mode 0)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-read-only-color       "#ffffff")
(setq djcb-read-only-cursor-type 'hollow)
(setq djcb-overwrite-color       "#cc0000")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "#ffffff")
(setq djcb-normal-cursor-type    'box)

(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
   (buffer-read-only
    (set-cursor-color djcb-read-only-color)
    (setq cursor-type djcb-read-only-cursor-type))
   (overwrite-mode
    (set-cursor-color djcb-overwrite-color)
    (setq cursor-type djcb-overwrite-cursor-type))
   (t 
    (set-cursor-color djcb-normal-color)
    (setq cursor-type djcb-normal-cursor-type))))

(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)


