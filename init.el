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

(setq INIT-EL "~/emacs.d/init.el")
(setq save-place-file "/emacs_saveplace") ;; keep my ~/ clean
(setq default-directory "/mnt/minus" )
(cd default-directory)
(setq MY-GREP-PATHS '(
                      "~/Desktop/minus/"
                      ))
(setq EMACS_BACKUP "~/emacs_backup")
;; (setq org-agenda-files (list "~/Desktop/personal/personal.todo" "~/Desktop/personal/minus.todo"))

(delete-selection-mode t)
;;; (winner-mode t)
(setq global-auto-revert-non-file-buffers t)
(setq revert-without-query (quote (".*")))
(fringe-mode 'none)
(modify-frame-parameters (selected-frame) (list (cons 'name "Emacs")))

(defun my-make-backup-file-name (file-name)
  "Create the non-numeric backup file name for file-name.n
   This customized version of this function is useful to keep all backups
   in one place, instead of all over the filesystem."
  (require 'dired)
  (message (concat "make-backup:" file-name))
  (if (file-exists-p EMACS_BACKUP)
      (concat (expand-file-name  EMACS_BACKUP)
          (dired-replace-in-string "/" "|" file-name))
    (concat file-name "~")))
(setq make-backup-file-name-function 'my-make-backup-file-name)

;; directories and autosave
(setq temporary-file-directory EMACS_BACKUP)
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

;; set load paths
(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))

(add-to-list 'load-path (expand-file-name
                         "lisp" (expand-file-name
                                 "org" (expand-file-name
                                        "src" dotfiles-dir))))


(add-to-list 'load-path "~/emacs.d/src/auctex")
(add-to-list 'load-path "~/emacs.d/src/auctex/preview")
(setq TeX-auto-save t) 
(setq TeX-parse-self t) 
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq visible-bell nil)
; (add-to-list 'load-path "~/emacs.d/icicles")

;; Load up Org Mode and Babel
;; customize todo char.
(add-hook 'org-mode-hook
          (lambda ()
            (modify-syntax-entry (string-to-char "\u25b6") "w") ;right
            (modify-syntax-entry (string-to-char "\u25a1") "w") ;square
            (modify-syntax-entry (string-to-char "\u25bc") "w") ;down
            (modify-syntax-entry (string-to-char "\u25ba") "w") ;down empty arrow
            (modify-syntax-entry (string-to-char "\u25b8") "w") ;right
            (modify-syntax-entry (string-to-char "\u00a0") "w") ;no-break space
            (modify-syntax-entry (string-to-char "\u2008") "w") ;punctuation space
            (modify-syntax-entry (string-to-char "\u03ec") "w") ;coptic shima char, like a beta.
            (modify-syntax-entry (string-to-char "\u03ff") "w") ;greek capital reversed
            (modify-syntax-entry (string-to-char "\u04a8") "w") ;curls
            ) 
          ) 
(setq org-todo-keywords
;      '((type "\u25a1(t)" "\u25a1\u2008DISCUSS(s)" "\u25a1\u2008\u04a8(r)" "\u25a1\u2008WAITING(w)" "\u25a1\u2008BLOCKED(b)" "|"  "\u25a1\u2008DONE(d)")
        '((type  "NEXT(n)" "WAITING(w)" "DELEGATED(d)" "SOMETIME" "|" "DONE(d)")))

;; (setq org-todo-keyword-faces
;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
;;         ("CANCELED" . (:foreground "blue" :weight bold))))

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
;; (setq org-log-states-order-reversed nil)
;; (setq org-log-done 'time)
;; log note settings
;; (setq org-log-note-headings
;;       '(
;;              ;;(done . "CLOSING NOTE %t")
;;              (state . "%t %s")
;;              ;;(state . "State %-12s %t")
;;              ;;(note . "Note taken on %t")
;;              (clock-out . "")))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; (require 'org-install)

;; (setq org-archive-location "/_personal/todo.archive.org")

(setq org-agenda-custom-commands 
      '(
        ("H" "Office and Home Lists"
         (
          ;(agenda)
          (tags "MINUS")
          (tags "PERSONAL")
          ))))

(defun zin/org-tag-match-context (&optional todo-only match)
  "Identical search to `org-match-sparse-tree', but shows the content of the matches."
  (interactive "P")
  (org-prepare-agenda-buffers (list (current-buffer)))
  (org-overview) 
  (org-remove-occur-highlights) 
  (org-scan-tags '(progn (org-show-entry) 
                         (org-show-context)) 
                 (cdr (org-make-tags-matcher match)) todo-only))

(setq org-ellipsis " \u25ba" )
; (setq org-ellipsis " \u25be" )



(setq org-link-frame-setup '((vm . vm-visit-folder-other-frame)
                             (gnus . org-gnus-no-new-news)
                             (file . find-file-other-window)
                             (wl . wl-other-frame))) 

(defun ded/org-show-next-heading-tidily ()
  "Show next entry, keeping other entries closed."
  (if (save-excursion (end-of-line) (outline-invisible-p))
      (progn (org-show-entry) (show-children))
    (outline-next-heading)
    (unless (and (bolp) (org-on-heading-p))
      (org-up-heading-safe)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (show-children)))

(defun ded/org-show-previous-heading-tidily ()
  "Show previous entry, keeping other entries closed."
  (let ((pos (point)))
    (outline-previous-heading)
    (unless (and (< (point) pos) (bolp) (org-on-heading-p))
      (goto-char pos)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (show-children)))

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

;; load up the main file
(org-babel-load-file (expand-file-name "starter-kit.org" dotfiles-dir))

;; (add-to-list 'load-path "~/emacs.d/emacs-color-theme-solarized/")
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

(defun color-theme-solarize-adjust ()
  (interactive)
  (color-theme-install
   '(color-theme-solarize-adjust
     (
      (foreground-color . "#9baaaa")
      (cursor-color . "#93a1a1" ) ; Cursor
      ;(background-color . "002b36") ; this is solarized default base 02 background color. it's too bright.
      ;(background-color . "#00111d") ; very good color! deep deep blue.
      (background-color . "#00112a") ; trying this one for now. slightly brighter deep blue.
      (help-highlight-face . underline)
      (ibuffer-dired-buffer-face . font-lock-function-name-face)
      (ibuffer-help-buffer-face . font-lock-comment-face)
      (ibuffer-hidden-buffer-face . font-lock-warning-face)
      (ibuffer-read-only-buffer-face . font-lock-type-face)
      (ibuffer-special-buffer-face . font-lock-keyword-face)
      (ibuffer-title-face . font-lock-type-face)
      (ps-line-number-color . "black")
      (ps-zebra-color . 0.95)
;      (tags-tag-face ((t (:foreground "#555"))))
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight)
      (highlight ((t (:foreground "#000000"  :background "#bbbbbb"))))
;      (mode-line-buffer-id ((,class (:foreground "#555555" :background nil :weight normal ))))
;      (mode-line ((,class (:foreground "#555555" :background "#333333" :weight normal :font "Consolas-11"))))
      )
     (ibuffer-deletion-face ((t (:foreground "#00ffff"))))
     (ibuffer-marked-face ((t (:foreground "#00ffff"))))
     (menu ((t (nil))))
     (show-paren-match-face ((t (:foreground "#ffffff" :background nil))))
     (show-paren-mismatch-face ((t (:background "#ffffff" :foreground nil))))
     (scroll-bar ((t ("#444444"))))
     (secondary-selection ((t (:foreground "#ffffff" :background "#444444"))))
     (org-done ((t (  :foreground "#586e75"))))
     (org-drawer ((t (:foreground  "#586e75"))))  
     (org-ellipsis ((t (:foreground "#555555" :underline nil))))      
     (org-hide ((t (:foreground "#000000"))))
     ; B&W based org-levels
     ;; (org-todo ((t (  :foreground "#b58900" :background nil))))
     ;; (org-level-1 ((t (  :foreground "#93a1a1"  ))))
     ;; (org-level-2 ((t (  :foreground  "#839496"))))
     ;; (org-level-3 ((t (  :foreground  "#657b83"))))
     ;; (org-level-4 ((t (  :foreground "#586e75"  :weight normal :slant normal))))
     ;; (org-level-5 ((t (  :foreground "#586e75"  :weight normal :slant normal))))
     ;; (org-level-6 ((t (  :foreground "#586e75"  :weight normal :slant normal))))
     ; Color based org-levels
     (org-todo ((t (  :foreground "#c61b7a" :background nil)))) ; magenta, darker.
     (org-level-1 ((t (  :foreground "#2aa494"  ))))
     (org-level-2 ((t (  :foreground  "#b38700"))))
     (org-level-3 ((t (  :foreground  "#368bc2"))))
     (org-level-4 ((t (  :foreground  "#859900"))))
     (org-level-5 ((t (  :foreground  "#6f74c9"))))
     (org-tag ((t (:bold nil :weight normal :foreground "#cb4b16"))))
     (org-table ((t (:foreground "#93a1a1"))))
     (org-link ((t (:underline nil :foreground  "#cb4b16" ))))
     ;; Other stuff.
     (isearch ((t (:underline nil :foreground "#ffffff" :underline nil :weight bold))))
     (region ((t (:inverse-video t)))) ; Visual
     ))
  )

;(set-face-attribute 'fringe nil :foreground "#222222")
;(set-face-attribute 'linum nil :foreground "#444444")
; (set-face-attribute 'fringe nil :foreground "#111111" :background "#000000")

(color-theme-sanityinc-solarized-dark)
(color-theme-solarize-adjust)

(global-hl-line-mode 0) ; turn it on for all modes by default


(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

;; configure ido
(setq org-completion-use-ido t)
(setq ido-auto-merge-delay-time 1)
(setq ido-everywhere t)
;(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(ido-mode 'both)
(setq 
  ido-save-directory-list-file "~/.emacs.d/emacs_ido.last"
  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ;; ido-work-directory-list
  ido-work-directory-list MY-GREP-PATHS
  ido-case-fold  t                 ; be case-insensitive
  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 300   ; should be enough
  ido-max-work-file-list      500   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)
  ido-enable-flex-matching t     ; don't try to be too smart
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-confirm-unique-completion nil) ; wait for RET, even with unique completion
;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))

;; (if window-system
;;     (progn
;;      (arrange-frame 140 50 2 5)
;;      ))

;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   (if window-system
;;   (progn
;;     (if (> (x-display-pixel-width) 1480)
;;         (add-to-list 'default-frame-alist (cons 'width 145))
;;            (add-to-list 'default-frame-alist (cons 'width 100)))
;;     ;; for the height, subtract a couple hundred pixels
;;     ;; from the screen height (for panels, menubars and
;;     ;; whatnot), then divide by the height of a char to
;;     ;; get the height we want
;;     (add-to-list 'default-frame-alist 
;;          (cons 'height (/ (- (x-display-pixel-height) 50)
;;                              (frame-char-height)))))))

; (set-frame-size-according-to-resolution)

(setq split-width-threshold nil) ; prevent horizontal splitting.

(defun bigframe ()
  (interactive)
  (arrange-frame 140 30 2 22)
  )

(defun my-set-frame-size-according-to-resolution ()
  (interactive)
  (arrange-frame
   (if (> (x-display-pixel-width) 1480) 145 135)
   (/ (- (x-display-pixel-height) 70) (frame-char-height))   
   2 22))

(my-set-frame-size-according-to-resolution)

; (arrange-frame 135 45 2 22)

;; (color-theme-carl)
;;(color-theme-solarized-light)
;;(color-theme-solarize-adjust)
;;(setq solarized-contrast 'high)
;;(setq solarized-visibility 'high)
;;(color-theme-solarized-dark)

(setq visual-line-mode nil)
(setq global-visual-line-mode nil)
(setq org-indent-mode t)
(setq org-startup-truncated nil)
;; (setq-default fill-column 110)
(setq auto-fill-mode -1)
(setq-default fill-column 99999)
(setq fill-column 99999)


(setq org-agenda-custom-commands
      '(("p" "Printed agenda"
         ((agenda "" ((org-agenda-ndays 7)                      ;; overview of appointments
                      (org-agenda-start-on-weekday nil)         ;; calendar begins today
                      (org-agenda-repeating-timestamp-show-all t)
                      (org-agenda-entry-types '(:timestamp :sexp))))
          (agenda "" ((org-agenda-ndays 1)                      ;; daily agenda
                      (org-deadline-warning-days 7)             ;; 7 day advanced warning for deadlines
                      (org-agenda-todo-keyword-format "[ ]")
                      (org-agenda-scheduled-leaders '("" ""))
                      (org-agenda-prefix-format "%t%s")))
          (todo "TODO"                                          ;; todos sorted by context
                ((org-agenda-prefix-format "[ ] %T: ")
                 (org-agenda-sorting-strategy '(tag-up priority-down))
                 (org-agenda-todo-keyword-format "")
                 (org-agenda-overriding-header "\nTasks by Context\n------------------\n"))))
         ((org-agenda-with-colors nil)
          (org-agenda-compact-blocks t)
          (org-agenda-remove-tags t)
          (ps-number-of-columns 2)
           (ps-landscape-mode t))
         ("~/agenda.ps"))
        ;; other commands go here
        ))

;; end orgmode

(setq python-shell-interpreter "/usr/bin/python2.7")

;; (set-face-attribute 'default nil :font "Monospace-11")
(set-face-attribute 'default nil :font "Consolas-11")
;;(set-face-attribute 'default nil :font "DejaVu Sans Mono-11")
;; (set-face-attribute 'default nil :font "Myriad Pro-12")
;;(set-face-attribute 'default nil :font "Inconsolata-11")
;; (set-face-attribute 'default nil :font "Droid Sans Mono-11")

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;; autoload changed files
(global-auto-revert-mode t)

(load "browse-kill-ring")

;; cut and paste windows bindings. note that this disables very
;; important ctrl x behavior.
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode nil)               ;; No region when it is not highlighted
(setq cua-keep-region-after-copy nil) 
;(require 'cua-lite)
;;(cua-lite 1)

;(require 'pc-select)
;(pc-selection-mode)

;(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
;(setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
;(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
;(setq select-active-regions t) ;  active region sets primary X11 selection
(global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
;(global-set-key (kbd "C-z") 'undo)

(require 'undo-tree)
(global-set-key (kbd "C-S-z") 'undo-tree-visualize)

;; desktop saving
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

(desktop-save-mode 1)

(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

(require 'desktop)
(desktop-read)     ;; restore desktop files (protected from errors)

(setq tag-file-name "/home/carlhu/TAGS")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; bind RET to py-newline-and-indent
(global-set-key (kbd "\C-m") 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; chrome default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; python
(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)

;; full screen f11
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key (kbd "<f11>") 'toggle-fullscreen)

;; Make new frames fullscreen by default. Note: this hook doesn't do
;; anything to the initial frame if it's in your .emacs, since that file is
;; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

(require 'web-mode)
(setq auto-mode-alist
      (append '(("\\.[Cc][Xx][Xx]$" . c++-mode)
                ("\\.[Cc][Pp][Pp]$" . c++-mode)
                ("\\.[Hh][Xx][Xx]$" . c++-mode)
                ("\\.[Tt][Cc][Cc]$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.i$" . c++-mode)    ; SWIG
                ("\\.mm?$" . objc-mode)
                ("_emacs" . lisp-mode)
                ("\\.el\\.gz$" . lisp-mode)
                ("\\.mak$" . makefile-mode)
                ("\\.conf$" . conf-mode)
                ("\\.go$" .  go-mode)
                ("\\.ke$" . kepago-mode)
                ("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                ("\\.textile$" . textile-mode)
                ("\\.kfn$" . kfn-mode)
                ("\\.rb$" . ruby-mode)
                ("\\.cml$" . xml-mode)
                ("\\.cg$" . cg-mode)
                ("\\.lua$" . lua-mode)
                ("\\.org$" . org-mode)
                ("\\.todo$" . org-mode)
                ("\\.txt$" . org-mode)
                ("\\.gpg$" . org-mode)
                ("\\.todo$" . org-mode)
                ("\\.r$" . R-mode)
                ("\\.R$" . R-mode)
                ("\\.md$" . markdown-mode)
                ("\\.scons$" . python-mode)
                ("\\.url$" . python-mode)
                ("\\.html$" . web-mode)
                ("\\.css$" . web-mode)
                ("SCons\\(cript\\|truct\\)" . python-mode)
                ("\\.gclient$" . python-mode)
                ) auto-mode-alist))

;; keyboard shortcuts
;;(global-set-key (kbd "\C-g") 'goto-line)
;; (global-set-key (kbd "\C-w") 'backward-kill-word)
;; (global-set-key (kbd "C-<f6>")  'org-table-recalculate)
(global-set-key (kbd "\C-x\C-m") 'execute-extended-command) ; alternative M-x shortcuts
(global-set-key (kbd "\C-c\C-m") 'execute-extended-command)
(global-set-key (kbd "\C-c\C-m") 'execute-extended-command)
(global-set-key (kbd "C-S-s") 'rgrep)
; (global-set-key (kbd "C-,") 'previous-error) 
(global-set-key (kbd "C-.") 'next-error)
(global-set-key (kbd "C-S-r") 'replace-string)
(global-set-key "\M-/" 'hippie-expand)

;; Make scroll smoother.
;; scroll one line at a time (less "jumpy" than defaults)
    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling  
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively  10000000)
(setq scroll-preserve-screen-position t)
(setq scroll-margin 0)
(setq auto-window-vscroll nil)
;(global-set-key [down] 'next-line)
;(global-set-key [up] 'previous-line)

;(require 'smooth-scroll)
;(smooth-scroll-mode t)

(defun scroll-down-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))

(defun scroll-up-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))

;;; (define-key global-map (kbd "C-,") 'scroll-down-in-place)
(define-key global-map (kbd "C-.") 'scroll-up-in-place)

;;; (global-set-key [mouse-4] 'scroll-down-in-place)
;;; (global-set-key [mouse-5] 'scroll-up-in-place)

;;; I want a key to open the current buffer all over the screen.
(defun all-over-the-screen ()
  (interactive)
;  (delete-other-windows)
  (split-window-horizontally)
  (balance-windows)
  (follow-mode 0)
  )
; (define-key global-map (kbd "<f10>") 'follow-delete-other-windows-and-split)
(define-key global-map (kbd "<f10>") 'all-over-the-screen)

(defun write-undistracted ()
  (interactive)
  (delete-other-windows)
  (set-frame-parameter nil 'fullscreen 'fullboth)
  (split-window-horizontally)
  (split-window-horizontally)
  (balance-windows)
  (follow-mode 0)
  (switch-to-buffer "*empty*")
  (shrink-window-horizontally 10)
  (other-window 2)
  (switch-to-buffer "*empty*")
  (shrink-window-horizontally 10)
  (other-window 2))
(define-key global-map (kbd "C-<f10>") 'write-undistracted)


; (all-over-the-screen) 

;; override the standard C-g quit with both close other windows and quit.
(defun my-quit()
  (interactive)
  ( if (active-minibuffer-window)
      (progn (select-window (active-minibuffer-window))
       (kill-line)
       )
    (progn
      ;; (delete-other-windows)
      (keyboard-quit)
      (keyboard-escape-quit)
      (abort-recursive-edit)
      (stop-using-minibuffer)
     (top-level)
      ))
  )

(when (require 'lusty-explorer nil 'noerror))

(require 'replace+)

(require 'midnight)

(midnight-delay-set 'midnight-delay 16200) ;; (eq (* 4.5 60 60) "4:30am")

;; navigation end-of-file behavior
;; (setq next-line-add-newlines t) ; messes up orgmode enter.

;; mark and go back behavior
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
; (global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
; (global-set-key (kbd "M-`") 'jump-to-mark)

;; prompt simplification
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;;; integrate ido with artist-mode
(defun artist-ido-select-operation (type)
  "Use ido to select a drawing operation in artist-mode"
  (interactive (list (ido-completing-read "Drawing operation: " 
                                          (list "Pen" "Pen Line" "line" "straight line" "rectangle" 
                                                "square" "poly-line" "straight poly-line" "ellipse" 
                                                "circle" "text see-thru" "text-overwrite" "spray-can" 
                                                "erase char" "erase rectangle" "vaporize line" "vaporize lines" 
                                                "cut rectangle" "cut square" "copy rectangle" "copy square" 
                                                "paste" "flood-fill"))))
  (artist-select-operation type))
(defun artist-ido-select-settings (type)
  "Use ido to select a setting to change in artist-mode"
  (interactive (list (ido-completing-read "Setting: " 
                                          (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars" 
                                                "Rubber-banding" "Trimming" "Borders"))))
  (if (equal type "Spray-size") 
      (artist-select-operation "spray set size")
    (call-interactively (artist-fc-get-fn-from-symbol 
                         (cdr (assoc type '(("Set Fill" . set-fill)
                                            ("Set Line" . set-line)
                                            ("Set Erase" . set-erase)
                                            ("Rubber-banding" . rubber-band)
                                            ("Trimming" . trimming)
                                            ("Borders" . borders)
                                            ("Spray-chars" . spray-chars))))))))
(add-hook 'artist-mode-init-hook 
          (lambda ()
            (define-key artist-mode-map (kbd "C-c C-a C-o") 'artist-ido-select-operation)
            (define-key artist-mode-map (kbd "C-c C-a C-c") 'artist-ido-select-settings)))


;; Tramp
(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)
(setq tramp-debug-buffer t)
(require 'tramp)

;; Orig nonworking pattern
;;(setq tramp-shell-prompt-pattern
      ;;"^[^#$%>\n]*[#$%>] *\\(\e\\[[0-9;]*[a-zA-Z] *\\)*"
;;      "*"
;; )

;; (global-set-key (kbd "<f4>") 'find-file)

;; start emacs server so that you can use emacsclient to open new files 
;; quickly in your one emacs session (which you start after a reboot and
;; keep open until your next reboot)
;; (server-start)

;; (setq debug-on-error t)
(require 'paren)
(set-face-background 'show-paren-match-face (face-background 'default))
(set-face-foreground 'show-paren-match-face "#def")
(set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)
(show-paren-mode 1)
(setq show-paren-delay 0)
(defadvice show-paren-function
      (after show-matching-paren-offscreen activate)
      "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
      (interactive)
      (if (not (minibuffer-prompt))
          (let ((matching-text nil))
            ;; is a close parentheses type character. Otherwise, there's not
            ;; Only call `blink-matching-open' if the character before point
            ;; really any point, and `blink-matching-open' would just echo
            ;; "Mismatched parentheses", which gets really annoying.
            (if (char-equal (char-syntax (char-before (point))) ?\))
                (setq matching-text (blink-matching-open)))
            (if (not (null matching-text))
                (message matching-text)))))
 
(setq hl-paren-colors
      '("orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(prefer-coding-system 'utf-8)

;; autocomplete
;;(add-to-list 'load-path "~/emacs.d/auto-complete")
;;(require 'fuzzy)
;;(turn-on-fuzzy-isearch)
;;(setq ac-auto-start nil)
;;(setq ac-auto-show-menu nil)
;;(require 'auto-complete-config)
;;(require 'auto-complete)
;;(require 'init-auto-complete)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;;(ac-config-default)

;;(require 'ac-anything)
;(define-key ac-complete-mode-map (kbd "C-/") 'ac-complete-with-anything)

(defadvice save-buffers-kill-emacs (around no-y-or-n activate)
  (flet ((yes-or-no-p (&rest args) t)
         (y-or-n-p (&rest args) t))
    ad-do-it))

;; ---------------------------------------------------------
;; anything configuration
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)

(setq anything-save-configuration-functions
      '(set-window-configuration . current-window-configuration))
(setq anything-idle-delay 0.1)
(setq anything-input-idle-delay 0.1)
(setq anything-samewindow nil)
(setq anything-quick-update t)
;; don't save history information to file
(remove-hook 'kill-emacs-hook 'anything-c-adaptive-save-history)
(setq anything-candidate-number-limit 300)
(setq anything-c-locate-db-file "/var/lib/mlocate/mlocate.db")
(setq anything-c-locate-options `("locate" "-d" ,anything-c-locate-db-file "-i" "-r" "--"))
(setq anything-persistent-action-use-special-display t)
(add-hook 'anything-after-persistent-action-hook 'which-func-update)
;; adaptive sort file is buggy
(remove-hook 'kill-emacs-hook 'anything-c-adaptive-save-history)

(require 'anything-grep)

;; (setq anything-grep-goto-hook
;;       (lambda ()
;;         (when anything-in-persistent-action
;;           (anything-persistent-highlight-point (point-at-bol) (point-at-eol)))))
;; (defalias 'ag 'anything-grep)

; (defun my-get-source-directory (path)  "/home/carlhu/Desktop/minus")

(defvar anything-c-source-find-my-emacs
  '((name . "Emacs Files")
    (candidates-file "/home/carlhu/files_emacs.txt" updating)
    (requires-pattern . 2)
    (candidate-number-limit . 5)
    (type . file)
    ))

(defvar anything-c-source-find-my-minus
  '((name . "Minus Files")
    (candidates-file "/home/carlhu/files_minus.txt" updating)
    (requires-pattern . 2)
    (candidate-number-limit . 25)
    (type . file)
    ))

(defvar anything-c-source-find-my-personal
  '((name . "Personal Files")
    (candidates-file "/home/carlhu/files_personal.txt" updating)
    (requires-pattern . 2)
    (candidate-number-limit . 9)
    (type . file)
    ))

(defvar anything-c-source-find-my-dropbox
  '((name . "Dropbox Files")
    (candidates-file "/home/carlhu/files_dropbox.txt" updating)
    (requires-pattern . 2)
    (candidate-number-limit . 9)
    (type . file)
    ))

(defvar anything-c-source-find-my-location
  '((name . "Location Files")
    (candidates-file "/home/carlhu/files_location.txt" updating)
    (requires-pattern . 2)
    (candidate-number-limit . 9)
    (type . file)
    ))

(defvar anything-c-source-find-all-my-files
  '((name . "My Files")
    (candidates-file "/home/carlhu/files.sorted.txt" updating)
    (requires-pattern . 0)
    (candidate-number-limit . 60)
    (type . file)
    ))

(require 'anything-exuberant-ctags)
(setq anything-exuberant-ctags-enable-tag-file-dir-cache t)
(setq anything-exuberant-ctags-cache-tag-file-dir "/_blog/")

(defun my-anything-occur ()
  (interactive)
  (anything '(
              anything-c-source-occur
              ;; anything-c-source-ctags
                ;; anything-c-source-locate
                ;; anything-c-source-imenu
                ;;anything-c-source-file-name-history
                ;;anything-c-source-etags-select
              
              nil)
              nil
              nil
              nil
              "*my-anything-switcher*"
              nil))

(defvar my-anything-c-source-buffers
  '((name . "Buffers")
    (candidates . anything-c-buffer-list)
    (requires-pattern . 0)
    (candidate-number-limit . 6)
    (type . buffer)))

(defun my-anything-switcher ()
  (interactive)
  (anything '(
              my-anything-c-source-buffers
              ;; anything-c-source-find-my-minus
              ;; anything-c-source-find-my-emacs
              ;; anything-c-source-find-my-personal
              ;; anything-c-source-find-my-dropbox
              ;; anything-c-source-find-my-location
              anything-c-source-find-all-my-files
              ;; anything-c-source-ctags
                ;; anything-c-source-locate
                ;; anything-c-source-imenu
                ;;anything-c-source-file-name-history
                ;;anything-c-source-etags-select
              
              nil) nil nil nil "*my-anything-switcher*" nil))

(defun which-func-update ()); used by exuberant ctags select.

     ;; (let (list)
     ;;   (save-window-excursion
	 ;; (switch-to-buffer (get-buffer-create "*Warn about privacy*"))
	 ;; (delete-other-windows)
	 ;; (erase-buffer)
	 ;; (insert "You are about to submit a bug report to the Org-mode mailing list.

(defun my-anything-drafts ()
  (interactive)
  (setq my-newly-selected-buffer nil)
  (save-window-excursion
    (delete-other-windows)
    (anything-exuberant-ctags-select)
    (setq my-newly-selected-buffer buffer-file-name))
  (find-file my-newly-selected-buffer))

(global-set-key (kbd "C-<f1>") 'my-anything-drafts)


(defun my-anything-switcher-at-point ()
  (interactive)
  (anything '(
              anything-c-source-occur
              anything-c-source-buffers
              anything-c-source-find-my-minus
              anything-c-source-find-my-emacs
              anything-c-source-find-my-personal
              anything-c-source-find-my-dropbox
              anything-c-source-find-my-location
              ;;anything-c-source-ctags
              ;; anything-c-source-locate
              ;; anything-c-source-imenu
              ;;anything-c-source-file-name-history
              ;;anything-c-source-etags-select
              )
            (word-at-point)
            nil
            nil
            nil
            "*my-anything-switcher-at-point*"
            nil))

(defun help-anything-at-point ()
  "default to thing at point for anything"
  (interactive)
  (anything '(
              anything-c-source-info-pages
              anything-c-source-info-elisp
              anything-c-source-man-pages
              anything-c-source-emacs-functions
              anything-c-source-emacs-variables
              anything-c-source-emacs-source-defun
              )
            (word-at-point)
            nil
            nil
            nil
            "*help-anything*"
            nil))

;; (global-set-key (kbd "<f1>") 'help-anything-at-point)

(defun my-anything-do-grep-2 (grep-command-param prompt-string only extensions default-string &optional recurse zgrep)
  "Launch grep with a list of ONLY files.
When RECURSE is given use -r option of grep and prompt user
to set the --include args of grep.
You can give more than one arg separated by space.
e.g *.el *.py *.tex.
If it's empty --exclude `grep-find-ignored-files' is used instead."
  (let* ((anything-compile-source-functions
          ;; rule out anything-match-plugin because the input is one regexp.
          (delq 'anything-compile-source--match-plugin
                (copy-sequence anything-compile-source-functions)))
         (exts extensions)
         (globs (and (not zgrep) (mapconcat 'identity exts " ")))
         (include-files globs)
         ;; Set `minibuffer-history' AFTER includes-files
         ;; to avoid storing wild-cards here.
         (minibuffer-history anything-c-grep-history)
         (funcall grep-command-param)
         (anything-c-grep-default-command (funcall grep-command-param))
         ;; Disable match-plugin and use here own highlighting.
         (anything-mp-highlight-delay     nil))
    (when include-files
      (setq include-files
            (and (not (string= include-files ""))
                 (mapconcat #'(lambda (x)
                                (concat "--include=" (shell-quote-argument x)))
                            (split-string include-files) " "))))
    ;; When called as action from an other source e.g *-find-files
    ;; we have to kill action buffer.
    (when (get-buffer anything-action-buffer)
      (kill-buffer anything-action-buffer))
    ;; `anything-find-files' haven't already started,
    ;; give a default value to `anything-ff-default-directory'.
    (setq anything-ff-default-directory (or anything-ff-default-directory
                                            default-directory))
    (anything
     :sources
     `(((name . "Grep")
        (header-name . (lambda (name)
                         (concat name "(C-c ? Help)")))
        (candidates
         . (lambda () 
             (funcall anything-c-grep-default-function only include-files zgrep)))
        (filtered-candidate-transformer anything-c-grep-cand-transformer)
        (candidate-number-limit . 500)
        (mode-line . anything-grep-mode-line-string)
        (keymap . ,anything-c-grep-map)
        (action . ,(delq
                    nil
                    `(("Find File" . anything-c-grep-action)
                      ("Find file other frame" . anything-c-grep-other-frame)
                      ,(and (locate-library "elscreen")
                            '("Find file in Elscreen"
                              . anything-c-grep-jump-elscreen))
                      ("Save results in grep buffer" . anything-c-grep-save-results)
                      ("Find file other window" . anything-c-grep-other-window))))
        (persistent-action . anything-c-grep-persistent-action)
        (persistent-help . "Jump to line (`C-u' Record in mark ring)")
        (requires-pattern . 1)
        (delayed . 0)
        ))
     :input default-string
     :buffer prompt-string)))

;; '%e' format spec is for --exclude or --include grep options.
;; '%p' format spec is for pattern.
;; '%f' format spec is for filenames.")
(defun my-grep-command ()  "LC_ALL=C grep -E -m 1000 -d recurse %e -niH -e %p %f" )
(defun my-grep-command-def ()  "python /_personal/grep-def.py %e =break= %p =break= %f" )
(defun my-grep-command-ref ()  "python /_personal/grep-ref.py %e =break= %p =break= %f" )

(defun test (fn) (funcall fn))
(test 'my-grep-command-def)

(defun my-anything-grep ()
  (interactive)
  (my-anything-do-grep-2
   'my-grep-command
   "Grep All"
   MY-GREP-PATHS '("*.py *.todo *.org *.css *.tex *.todo* *.org* *.el* *.conf *.html")
   (thing-at-point 'symbol)
   '(4)))

(defun my-anything-grep-sql ()
  (interactive)
  (my-anything-do-grep-2
   'my-grep-command
   "Grep All"
   MY-GREP-PATHS '("*.sql")
   (thing-at-point 'symbol)
   '(4)))

(defun my-anything-grep-ref ()
  (interactive)
  (my-anything-do-grep-2
   'my-grep-command-ref
   "Grep References"
   MY-GREP-PATHS '("*.py *.todo *.org *.css *.tex *.todo* *.org* *.el* *.conf")
   (thing-at-point 'symbol)
;;   (format "[^a-zA-Z_\d]%s[^a-zA-Z_\d\-]" (thing-at-point 'symbol))
   '(4)))

(defun my-anything-grep-def ()
  (interactive)
  (my-anything-do-grep-2
   'my-grep-command-def
   "Grep Definitions"
   MY-GREP-PATHS '("*.py *.todo *.org *.css *.tex *.todo* *.org* *.el*")
   (thing-at-point 'symbol)
;;   (format "(function|defun|def|class|function)\s*%s[^a-zA-Z_\d\-]" (thing-at-point 'symbol))
   '(4)))

;;;;;;;;;;;;;; end anything ;;;;;;;;;;;;;;;;;;;

  ;; XEmacs default for moving point to a given line number
(global-set-key (kbd "M-g") 'goto-line)

;; (require 'annoying-arrows-mode)
;; (annoying-arrows-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; To navigate to a bookmark (linking to a file or directory), just press
;; `C-x r b'. You'll be prompted for the bookmark name, and it will open that
;; file or directory.

;; where to save the bookmarks
(setq bookmark-default-file "~/emacs.d/bookmarks.txt")

;; each command that sets a bookmark will also save your bookmarks
(setq bookmark-save-flag 1)

;; use inactive face for mode-line in non-selected windows
(setq mode-line-in-non-selected-windows t)

(setq echo-keystrokes 0.001)
(temp-buffer-resize-mode t) ; auto-fit the *Help* buffer to its contents

;; kill buffer without confirmation (if not modified)
(defun my-kill-this-buffer ()
  "Kill the current buffer without confirmation (if not modified)."
  (interactive)
;;;   (let ((bufname (buffer-name)))
;;;     (if (or
;;;          (string-equal "*Group*" bufname))
;;;         (bury-buffer bufname)
      (kill-buffer nil))
;;;       ))

(global-set-key (kbd "<S-f12>") 'my-kill-this-buffer)

;; org heading goto.
(defun my-goto-org-heading ()
  (interactive)
  (org-refile t))

(global-set-key (kbd "M-s") 'my-goto-org-heading)

;; REDO (a better way to handle undo and redo)
;; http://www.wonderworks.com/
;;(require 'redo)
;;(global-set-key [(control +)] 'redo)

(defun my-hide-sublevels-and-center ()
  (interactive)
  (hide-sublevels 1)
  (recenter-top-bottom)
  )

;; doesn't work. M-l overwridden back to default.
;; (add-hook 'org-mode-hook '(lambda () (global-set-key (kbd "M-l") 'my-hide-sublevels-and-center)))

; (global-set-key (kbd "<f12>") 'save-buffer)

(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)


(global-set-key (kbd "C-c C-o") 'org-mode)

(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(custom-set-variables
 '(TeX-command-list (quote (("XeLaTeX_SyncteX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run XeLaTeX") ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command") ("Jump to PDF" "%V" TeX-run-discard-or-function nil t :help "Run Viewer"))))
 '(TeX-modes (quote (tex-mode plain-tex-mode texinfo-mode latex-mode doctex-mode)))
 )

(setq org-export-latex-default-packages-alist
      '(
        ("utf8" "inputenc" t)
        ("T1"   "fontenc"   t)
        (""     "fixltx2e"  nil)
        (""     "wrapfig"   nil)
        (""     "longtable"      t)
        (""     "float"  t)
        (""     "soul"  t)
        (""     "textcomp"  t)
        (""     "marvosym"  t)        
        (""     "wasysym"   t)
        (""     "latexsym"  t)
        (""     "amssymb"   t)
        )
      )

;;; (require 'ipython)
(setq py-shell-name "python")

(require 'dbus)

;; Minus Todo export
(defun todo-export ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (call-process-shell-command "/bin/bash -c \"cd ~/Desktop/personal; python sync.py;\"" nil 0 )
  (message "<f6>. Commit all. Pull all. Partial push."))

(global-set-key (kbd "<f6>") 'todo-export)

(defun todo-export-push ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (call-process-shell-command "/bin/bash -c \"cd ~/Desktop/personal; python sync.py push;\"" nil 0 )
  (message "<C-<f6>. Commit all. Pull all. Push all."))

(global-set-key (kbd "C-<f6>") 'todo-export-push)

(defun todo-export-rsync-only ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (call-process-shell-command "/bin/bash -c \"cd ~/Desktop/personal; python sync.py rsync;\"" nil 0 )
  (message "<f5>. Rsync only."))

(global-set-key (kbd "<f5>") 'todo-export-rsync-only)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add export to markdown from org
(load "~/emacs.d/src/org/contrib/lisp/org-export-generic.el")

(org-set-generic-type
 "Carl Text" 
 '(:file-suffix ".txt"
   :key-binding ?c
   :title-format "%s\n"
   :title-suffix ?=
   :body-header-section-numbers nil
   :body-header-section-number-format ""
   :body-section-header-prefix	("\n\u25AA "
                                 "    \u25AA "
                                 "        \u25AA "
                                 "            \u25AA "
                                 "                \u25AA "
                                 "                    \u25AA "
                                 )
   :body-section-header-format	"%s"
   :body-section-header-suffix "\n"
   :todo-keywords-export nil
   :body-line-format "%s\n\n"
   :body-tags-export	nil
   :body-tags-prefix	" <tags>"
   :body-tags-suffix	"</tags>\n"
   ;;:body-section-prefix	"<secprefix>\n"
   ;;:body-section-suffix	"</secsuffix>\n"
   :body-line-export-preformated t
   :body-line-fixed-prefix	""
   :body-line-fixed-suffix	"\n\n"
   :body-line-fixed-format	"%s\n"
   :body-list-prefix	"\n"
   :body-list-suffix	"\n"
   :body-list-format	"\u25AA %s\n"
   ;;:body-number-list-prefix	"<ol>\n"
   ;;:body-number-list-suffix	"</ol>\n"
   ;;:body-number-list-format	"<li>%s</li>\n"
   ;;:body-number-list-leave-number	t
   :body-list-checkbox-todo	"[_] "
   :body-list-checkbox-todo-end	""
   :body-list-checkbox-done	"[X] "
   :body-list-checkbox-done-end ""
   :body-line-format	"%s"
   :body-line-wrap	0
   :body-text-prefix	""
   :body-text-suffix	""
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun switch-to-minus-todo ()
  (interactive)
  (find-file MINUS-TODO)
  (color-theme-solarize-adjust)
  ;;(switch-to-buffer "minus.todo") 
  ;;(all-over-the-screen)
  ;;(follow-delete-other-windows-and-split)
  ;;(goto-line 0)
  ;;  (recenter-top-bottom)
  )

(defun switch-to-personal-todo ()
  (interactive)
  (find-file PERSONAL-TODO)
  (color-theme-solarize-adjust)
  (org-mode)
  ;;(switch-to-buffer "personal.todo")
  ;(follow-delete-other-windows-and-split)
  ;(goto-line 0)
  ;;(all-over-the-screen)
;;  (recenter-top-bottom)
  )

(defun switch-to-blank ()
  (interactive)
  (find-file "~/Desktop/personal/blank.org")
  (color-theme-solarize-adjust))

(defun switch-to-notes ()
  (interactive)
  (find-file "~/Desktop/personal/notes.org")
  (beginning-of-buffer)
  (outline-next-visible-heading 1)
  (color-theme-solarize-adjust))

(defun switch-to-init-el ()
  (interactive)
   (find-file INIT-EL)
  ;; (switch-to-buffer "init.el")
  ;; (follow-delete-other-windows-and-split)
  ;;(all-over-the-screen)
;;   (recenter-top-bottom)
  )

;; move line up or down
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


;; disable scrollbar
(scroll-bar-mode -1)
;; (set-scroll-bar-mode 'right)

(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

;; seems flaky. (add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

(add-to-list 'load-path "~/emacs.d/sunrise-commander")
(require 'sunrise-x-buttons)
(require 'sunrise-x-loop)
(require 'sunrise-x-modeline)
(require 'sunrise-x-tree)

(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
        (end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2)
  (message "Line appended to kill-ring.")
  )

;; The file names are absolute, not relative, locations
;;    ;;     - e.g. /foobar/mthesaur.txt.cache, not mthesaur.txt.cache
(setq synonyms-file "~/emacs.d/thesaurus/mthesaur.txt")
(setq synonyms-cache-file "~/emacs.thesaurus.cache")
(require 'synonyms)

(require 'epa-file)
(epa-file-enable)

;; make isearch go to beginning of word instead of end.
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
(defun my-goto-match-beginning ()
  (when isearch-forward (goto-char isearch-other-end)))

;;autoindent mode...trying this out.
;(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
;(require 'auto-indent-mode) ; buggy
;(auto-indent-global-mode)

;; latex settings
(require 'org-latex)

(defun my-process-latex ()
  (interactive)
  (save-buffer)
  (delete-other-windows)
  (find-file "~/Desktop/personal/pitch_minus/pitch_intro_table.org")
  (org-export-as-latex 5 nil nil nil t nil)
;  (async-shell-command "/bin/bash -c \"cd ~/Desktop/personal/pitch_minus; xelatex --synctex=1 -interaction=nonstopmode seriesA.tex;  \"")
  (call-process-shell-command "/bin/bash -c \"cd ~/Desktop/personal/pitch_minus; xelatex --synctex=1 -interaction=nonstopmode seriesA.tex;  \"" nil 0 )
  (enlarge-window 20)
  )

(setq org-latex-to-pdf-process 
  '("xelatex -interaction nonstopmode %f"
    "")) ;; for multiple passes

(defun my-process-latex2 ()
  (interactive)
  (save-buffer)
  ;; (delete-other-windows)
  ;; (find-file "~/Desktop/pitch/pitch.org")
  (org-export-as-pdf 1)
  ;;  (org-export-as-latex 5 nil nil nil nil nil)
  ;;  (async-shell-command "/bin/bash -c \"cd ~/Desktop/pitch; xelatex -interaction=nonstopmode pitch.tex; \" ")
  (delete-other-windows)
  ;;  (enlarge-window 20)
  )

(defun my-process-latex3 ()
  (interactive)
  (save-buffer)
  (async-shell-command (format "/bin/bash -c \"python /home/carlhu/Desktop/personal/my_xelatex.py -f %s ; \"" (buffer-file-name )))
  (delete-other-windows)
  )

(defun my-process-latex4 ()
  (interactive)
  (save-buffer)
  (async-shell-command (format "/bin/bash -c \"python /home/carlhu/Desktop/personal/my_xelatex.py -f %s -o open; \"" (buffer-file-name )))
  (delete-other-windows)
  )

;;; (define-key global-map (kbd "<f5>") 'my-process-latex3) 
; (define-key global-map (kbd "C-<f5>") 'my-process-latex4)

(setq org-agenda-custom-commands 
      '(("d" "Draft" tags-todo "DRAFT" ;; (1) (2) (3) (4)
         ((org-agenda-files (file-expand-wildcards "~/Desktop/blog/src/content/*.org")) ;; (5)
          (org-agenda-sorting-strategy '(priority-up effort-down))) ;; (5) cont.
         ) ;; (6)
        ;; ...other commands here
        ))

(defun my-blog-export ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (start-process-shell-command "export-html" "export-html" (format "/bin/bash -c \"cd /_blog; python build.py \" " ))
;  (start-process-shell-command "export-html" "export-html" (format "/bin/bash -c \"cd /_blog; python build.py %s \" " (buffer-file-name)))
  ;; (delete-other-windows)
  ;; (todo-export)
  (message "Templates generated.")
  )

(defun export-to-tex ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (start-process-shell-command "export-to-tex" "export-to-tex" "/bin/bash -c \"python /_personal/export-to-tex.py %s \" " get-fullpath-current-file) 
)

(defun my-pattern-export-orgmode (pattern)
  (interactive "sPattern like <return>, \"tag1, tag2\", or *: ")
  (save-buffer)
  (save-some-buffers t)
  (shell-command-on-region (mark) (point)
                           (format
                               "/bin/bash -c \"cd /home/carlhu/Desktop/personal; /usr/bin/python /home/carlhu/Desktop/personal/org_export/org_parents.py %s '%s'; \""
                               (format "/home/carlhu/tmp/%s.export.txt" (file-name-sans-extension (buffer-name))) pattern) nil nil nil)
  (find-file (format "/home/carlhu/tmp/%s.export.txt" (file-name-sans-extension (buffer-name)))))

(defun my-org2html ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (save-excursion 
    (if (and mark-active (/= (point) (mark))) () (org-mark-subtree))
    (shell-command-on-region (mark) (point)
                             (format
                              "/bin/bash -c \"cd /home/carlhu/Desktop/personal; /usr/bin/python /home/carlhu/Desktop/personal/org_export/org2html.py %s '%s'; \""
                              (format "/home/carlhu/tmp/export.html") "") nil nil nil)
    (keyboard-escape-quit)))

(defun my-org2html-open ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (save-excursion 
    (if (and mark-active (/= (point) (mark))) () (org-mark-subtree))
    (shell-command-on-region (mark) (point)
                             (format
                              "/bin/bash -c \"cd /home/carlhu/Desktop/personal; /usr/bin/python /home/carlhu/Desktop/personal/org_export/org2html.py %s '%s' open; \""
                              (format "/home/carlhu/tmp/export.html") "") nil nil nil)
    (keyboard-escape-quit)))


(defun integer-bounds-of-integer-at-point ()
     "Return the start and end points of an integer at the current point.
   The result is a paired list of character positions for an integer
   located at the current point in the current buffer.  An integer is any
   decimal digit 0 through 9 with an optional starting minus symbol
   \(\"-\")."
     (save-excursion
       (skip-chars-backward ".,+-0123456789")
       (if (looking-at "-?[0-9.,]+")
           (cons (point) (1- (match-end 0))) ; bounds of integer
         nil))) ; no integer at point

(put 'integer 'bounds-of-thing-at-point
     'integer-bounds-of-integer-at-point)

(defun commafy-this ()
  (interactive)
  ;; (setq myBoundaries (bounds-of-thing-at-point 'integer))
  ;; (setq p1 (car myBoundaries))
  ;; (setq p2 (+ (cdr myBoundaries) 1))
  (setq p1 (mark))
  (setq p2 (point))
  (shell-command-on-region p1 p2
                           "/bin/bash -c \"cd /home/carlhu/Desktop/personal;  /usr/bin/python commafy.py; \""
                           nil t nil))

;; (defun commafy-this ()
;;   (interactive)
;;   (if (and mark-active (/= (point) (mark))) 
;;       ((setq p1 (mark))
;;        (setq p2 (point)))
;;     ((setq myBoundaries (bounds-of-thing-at-point 'integer))
;;      (setq p1 (car myBoundaries))
;;      (setq p2 (+ (cdr myBoundaries) 1))))
;;   (shell-command-on-region p1 p2
;;                            "/bin/bash -c \"cd /home/carlhu/Desktop/personal;  /usr/bin/python commafy.py; \""
;;                            nil t nil))

(global-set-key (kbd "C-c C-,") 'commafy-this)
(global-set-key (kbd "C-,") 'commafy-this)


(defun my-org-mark-subtree ()
  "Mark the current subtree.
This puts point at the start of the current subtree, and mark at the end.

If point is in an inline task, mark that task instead."
  (interactive)
  (let ((inline-task-p
	 (and (featurep 'org-inlinetask)
	      (org-inlinetask-in-task-p)))
	(beg))
    ;; Get beginning of subtree
    (cond
     (inline-task-p (org-inlinetask-goto-beginning))
     ((org-at-heading-p) (beginning-of-line))
     (t (org-with-limited-levels (outline-previous-visible-heading 1))))
    (setq beg (point))
    ;; Get end of it
    (if	inline-task-p
	(org-inlinetask-goto-end)
      (org-end-of-subtree t t))
    ;; Mark zone
    (push-mark (point) nil t)
    (goto-char beg)))

(defun my-import-orgmode ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (save-excursion 
    (if (and mark-active (/= (point) (mark))) () (my-org-mark-subtree))
    (shell-command-on-region (mark) (point)
                             "/bin/bash -c \"cd /home/carlhu/Desktop/personal;  /usr/bin/python /home/carlhu/Desktop/personal/import_org.py; \""
                             nil t nil)))

(defun my-orgmode-format-heading ()
  (interactive)
  (save-excursion 
    (if (and mark-active (/= (point) (mark))) () (org-mark-subtree))
    (shell-command-on-region (mark) (point)
                             "/bin/bash -c \"cd /home/carlhu/Desktop/personal;  /usr/bin/python /home/carlhu/Desktop/personal/my_org_format_line.py; \""
                             nil t nil)))
(global-set-key (kbd "M--") 'my-orgmode-format-heading)

(eval-after-load 'latex 
  '(define-key LaTeX-mode-map (kbd "<f5>") 'my-process-latex4))

(defun gh () ; git history
  (interactive)
  (start-process-shell-command "my-git-log" nil
                               (format "/bin/bash -c \" cd %s; /usr/bin/gitk %s \"" (file-name-directory buffer-file-name)
                                       buffer-file-name)))

(defun shell-command-on-region-to-string (start end command)
  (with-output-to-string
    (shell-command-on-region start end command standard-output)))

(defun my-copy-orgmode ()
  (interactive)
  (save-buffer)
  (save-some-buffers t)
  (save-excursion 
    (if (and mark-active (/= (point) (mark))) () (org-mark-subtree))
    (kill-new (shell-command-on-region-to-string (mark) (point) "/bin/bash -c \"cat \"" )))
  (keyboard-escape-quit))

; (add-hook 'tex-mode-hook (lambda () (define-key tex-mode-map (kbd "<f5>") 'my-process-latex3)))
; doesn't work for some reason. (add-hook 'tex-mode-hook (lambda () (define-key tex-mode-map (kbd "C-<f5>") 'my-process-latex4)))
;; (add-hook 'org-mode-hook (lambda () (define-key org-mode-map (kbd "<f5>") 'my-process-latex2)))

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

(require 'rebox2)
(global-set-key [(meta q)] 'rebox-dwim)
(global-set-key [(shift meta q)] 'rebox-cycle)

(require 'yasnippet-bundle)
(yas/load-directory "~/Desktop/personal/yasnippet")

;; python snippet in orgmode
(defun python-snippet ()
  (interactive)
  (insert "#+BEGIN_SRC python\n"
          "#+END_SRC"))

(define-key global-map (kbd "M-c") 'quick-copy-line)

(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f8>") 'switch-to-minibuffer-window)

;; show linecount in modeline
(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

(setq-default mode-line-format
              '("  " mode-line-modified
                (list 'line-number-mode "  ")
                (:eval (when line-number-mode
                         (let ((str "L%l"))
                           (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
                             (setq str (concat str "/" my-mode-line-buffer-line-count)))
                           str)))
                "  %p"
                (list 'column-number-mode "  C%c")
                "  " mode-line-buffer-identification
                "  " mode-line-modes))

(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)

(defun kill-current-buffer-and-frame ()
  (interactive)
  (kill-buffer)
  (delete-window)
  )

;;(add-to-list 'load-path "~/.emacs.d/textmate.el")
;;(require 'textmate)

(defun djcb-gtags-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
    (let ((olddir default-directory)
          (topdir (read-directory-name  
                    "gtags: top of source tree:" default-directory)))
      (cd topdir)
      (shell-command "gtags && echo 'created tagfile'")
      (cd olddir)) ; restore   
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))

;; ido find file in project -- todo: customize approach below to do project search.

;; Display ido results vertically, rather than horizontally
;;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
;;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(defun file-names-to-completion-list (file-names)
  "Given a list of FILE-NAMES produces a completion list.
The list returned has a list of unique file names in position 0 and a
hash table from file name to a list of full paths for that file name in
position 1."
  (let (display
        key
        value
        (table (make-hash-table :test 'equal)))
    (mapc (lambda (path)
            (setq key (replace-regexp-in-string my-project-file-regex
                                                my-project-file-replace path))
            (setq value (or (gethash key table) (list)))
            (push path value)
            (puthash key value table))
          file-names)
    (maphash (lambda (key value) (push key display)) table)
    (list display table)))

(defun file-name-from-completion-list (clist)
  "Produces a file name from a completion list using ido.
CLIST is a completion list produced by 'file-names-to-completion-list'."
  (let* ((key (ido-completing-read "Project file: " (car clist) nil t))
         (value (gethash key (nth 1 clist)))
         (value (if (> (length value) 1)
                    (ido-completing-read "Disambiguate: " value nil t)
                  (car value))))
    value))

(defun ido-find-file-in-tag-files ()
  "Uses ido to open a file from among those listed in a tag file."
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (let* ((ido-case-fold nil)
           (clist (file-names-to-completion-list (tags-table-files))))
      (find-file (expand-file-name (file-name-from-completion-list clist))))))

(require 'linum)
(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
; (global-set-key (kbd "C-<f6>") 'global-linum-mode)    
(linum-mode 0)
(global-linum-mode 0)

(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(defun my-goto-first-org-item ()
  (interactive)
  (beginning-of-buffer)
  (outline-next-visible-heading 1)
)

(defun my-mark-all ()
  (interactive)
  (clipboard-kill-ring-save (buffer-end 0) (buffer-end 1))
  (message "Complete buffer copied to clipboard.")
  )

(defun my-mark-whole-buffer ()
"Copy the whole buffer into the kill ring"
(interactive)
(mark-whole-buffer)
)

(define-key global-map (kbd "M-C-a") 'my-mark-all)


;; (define-key global-map (kbd "M-C-a") 'my-mark-whole-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%Y-%m-%d %H:%M ") 
                   ((equal prefix '(4)) "%Y-%m-%d ")
                   ((equal prefix '(16)) "%A, %d. %B %Y ")))
          )
      (insert (format-time-string format))))

(define-key global-map (kbd "C-M-d") 'my-insert-date)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode line setup
(setq-default
 mode-line-format
 '(; Position, including warning for 80 columns
   ; directory and buffer/file name
   " "
   ;; (:propertize (:eval (shorten-directory default-directory 30))
   ;;              face mode-line-folder-face)
   (:propertize "%f"
                face mode-line-filename-face)
   ;; (:propertize "%b"
   ;;              face mode-line-filename-face)
   (:eval
    (cond (buffer-read-only
           (propertize ".RO" 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize "*  " 'face 'mode-line-modified-face))
          (t "   ")))
   (:propertize "   %P     %4l," face mode-line-position-face)
   (:eval (propertize "%c" 'face
                      (if (>= (current-column) 80)
                          'mode-line-position-face
                        'mode-line-position-face)))
   ;; emacsclient [default -- keep?]
   mode-line-client
   "  "
   ; read-only or modified status
;   narrow [default -- keep?]
   "  %n "
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   ;; (vc-mode vc-mode)
   ;; "  %["
   (:propertize mode-name
                face mode-line-mode-face)
;   "%] "
   ;; (:eval (propertize (format-mode-line minor-mode-alist)
   ;;                    'face 'mode-line-minor-mode-face))
   ;; (:propertize mode-line-process
   ;;              face mode-line-process-face)
   ;; (global-mode-string global-mode-string)
   ;; "    "
   ;; ; nyan-mode uses nyan cat as an alternative to %p
   ;; (:eval (when nyan-mode (list (nyan-create))))
   ))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
    :foreground "#777777" :background "#373737"
    :font "Consolas-11"
    :inverse-video nil
    :weight 'normal
    :box '(:line-width 3 :color "gray20" :style nil)
    )
(set-face-attribute 'mode-line-inactive nil
                    :inherit 'mode-line
    :foreground "#999999" :background "#373737"
    :weight 'normal
    :inverse-video nil
    :box '(:line-width 3 :color "gray20" :style nil)
    ;; :box '(:line-width 1 :color "gray40" :style nil)
    )
(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line
    :weight 'normal
;    :foreground "#4271ae"
    :box '(:line-width 1 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line
    :foreground "#eeeeee"
    )
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line
    )
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line
    ;;     :foreground "#eab700" ;; yellow
    :foreground "#eeeeee"
    :weight 'normal)
(set-face-attribute 'mode-line-position-face nil
                    :inherit 'mode-line
                    :foreground "#eeeeee"
                    :weight 'normal
    )
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line
    :foreground "#eeeeee"
    )
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line
    :height 110)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line
    )
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line
    :weight 'normal
    )

; between invoking org-refile and displaying the prompt (which
; triggers window-configuration-change-hook) tags might adjust,
; which invalidates the org-refile cache
(defadvice org-refile (around org-refile-disable-adjust-tags)
  "Disable dynamically adjusting tags"
  (let ((ba/org-adjust-tags-column nil))
    ad-do-it))
(ad-activate 'org-refile)

;; To preserve (somewhat) the integrity of your archive structure while archiving lower level items to a file, you can use the following
(defadvice org-archive-subtree (around my-org-archive-subtree activate)
  (let ((org-archive-location
         (if (save-excursion (org-back-to-heading)
                             (> (org-outline-level) 1))
             (concat (car (split-string org-archive-location "::"))
                     "::* "
                     (car (org-get-outline-path)))
           org-archive-location)))
    ad-do-it))

;; ====================
;; insert date and time

(defvar current-date-time-format "%Y %B %d"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )

;; Rename file
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(global-set-key (kbd "C-c w") 'rename-file-and-buffer)

(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))
(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file)

;; Markdown conveniences
(defun underline (c)
  (save-excursion
    (let (w)
      (move-end-of-line 1)
      (setq w (current-column))
      (newline)
      (insert (apply 'concat (make-list w c)))
    )))

(defun markdown-under-section ()
  (interactive)
  (underline "-")
)

(global-set-key (kbd "C-c C-h") 'markdown-under-section)

;; ESS ;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "/home/carlhu/emacs.d/ess-12.09/lisp/ess-site.el")
(require 'ess-site)
(setq inferior-R-program-name "R")

;; (global-set-key "\C-c\C-d" 'insert-current-date-time)
;; (global-set-key "\C-c\C-t" 'insert-current-time)

;; keys

(global-set-key [(control next)] 'next-buffer) 
(global-set-key [(control prior)] 'previous-buffer)
(define-key global-map (kbd "M-c") 'quick-copy-line)
;(define-key global-map (kbd "<f4>") 'magit-status)
; (global-set-key (kbd "\C-x\C-e") 'org-export-as-html)
(define-key global-map (kbd "C-/") 'hippie-expand) 
(define-key minibuffer-local-map (kbd "C-/") 'hippie-expand)
(define-key global-map (kbd "C-=") 'kill-current-buffer-and-frame)
(define-key global-map (kbd "M-<f3>") 'switch-to-minus-todo)
(define-key global-map (kbd "<f3>") 'switch-to-personal-todo)
(define-key global-map (kbd "C-<f3>") 'switch-to-init-el)
;; (define-key global-map (kbd "<f4>") 'org-archive-to-archive-sibling)
(define-key global-map (kbd "<f4>") 'org-archive-subtree)

; (define-key global-map (kbd "C-<f4>") 'ido-kill-buffer)
(define-key global-map (kbd "C-<escape>") 'switch-to-blank)

;(global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
;(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "<f2>") 'my-anything-occur)
(global-set-key (kbd "<f1>") 'my-anything-switcher)
(global-set-key (kbd "C-M-<up>") 'my-goto-first-org-item)
;; (global-set-key (kbd "M-t") 'my-anything-switcher-at-point)
;;(global-set-key (kbd "M-t") 'ido-switch-buffer)
(global-set-key (kbd "C-c n") 'switch-to-notes)
(global-set-key (kbd "C-S-f") 'my-anything-grep)
(global-set-key (kbd "C-<f2>") 'my-anything-grep)
(global-set-key (kbd "M-<f6>") 'my-anything-grep-sql)
(global-set-key (kbd "<f7>") 'my-anything-grep-def)
(global-set-key (kbd "S-<f7>") 'my-anything-grep)
(global-set-key (kbd "C-<f7>") 'my-anything-grep-ref)
(global-set-key (kbd "M-C-<f2>") 'anything-grep)
(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)
(global-set-key (kbd "C-S-o")  'occur)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(define-key global-map (kbd "C-g") 'keyboard-escape-quit)
(global-set-key (kbd "C-c C-8") 'org-ctrl-c-star)
;;; esc quits
(define-key global-map (kbd "<escape>") 'keyboard-escape-quit)
(define-key minibuffer-local-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-ns-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-completion-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-must-match-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-isearch-map [escape] 'keyboard-escape-quit)

(define-key global-map (kbd "<f9>") 'split-window-horizontally)

;; textmate experiment
(define-key global-map (kbd "M-]")  'py-shift-right)
(define-key global-map (kbd "M-[") 'py-shift-left)
; (define-key global-map (kbd "<f5>") 'textmate-goto-file)
; (define-key global-map (kbd "<f5>") 'textmate-goto-symbol)

;; Tell orgmode table to consider extra chars to be numbers.
(setq org-table-number-regexp "^\\([<>]?[-+^.0-]*[0-9-\?][-+^.0-9eE dDx()%:xX,]*\\|\\(0[xX]\\)[0-9a-fA-F]+\\)$")

(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<left>") 'windmove-left)

(global-set-key (kbd "M-C-w") 'clipboard-kill-ring-save)

(setq my-org-heading-finder
   [?\C-u ?\C-c ?\C-w])

(define-key global-map (kbd "<f8>") 'my-org-heading-finder)
; (define-key global-map (kbd "C-<f1>") 'other-window)


(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map (kbd "C-<f5>") 'my-org2html)
             (define-key org-mode-map (kbd "C-S-<f5>") 'my-org2html-open)
             (define-key org-mode-map (kbd "C-c C-<f5>") 'my-pattern-export-orgmode)
             (define-key org-mode-map (kbd "M-<f5>") 'my-import-orgmode)
             (define-key org-mode-map (kbd "<f5>") 'my-blog-export)
             (define-key org-mode-map (kbd "<f4>") 'org-archive-subtree)
;             (define-key org-mode-map (kbd "<f7>") 'export-to-tex)
             ;; (define-key org-mode-map (kbd "M-W") 'org-copy-special)
             (define-key org-mode-map (kbd "M-W") 'my-copy-orgmode)             
             (define-key org-mode-map (kbd "C-S-w") 'org-cut-special)
             (define-key org-mode-map (kbd "C-c C-d") 'org-time-stamp)
             (define-key org-mode-map (kbd "C-t") 'org-ctrl-c-ctrl-c)
             ))

;;; (define-key global-map (kbd "M-W") 'org-copy-special)


(add-hook 'html-mode-hook
          '(lambda ()
             (define-key html-mode-map (kbd "<f5>") 'my-blog-export)))

(add-hook 'css-mode-hook
          '(lambda ()
             (define-key css-mode-map (kbd "<f5>") 'my-blog-export)))

(add-hook 'xml-mode-hook
          '(lambda ()
             (define-key xml-mode-map (kbd "<f5>") 'my-blog-export)))


(message "My init file is completely loaded.")


