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


