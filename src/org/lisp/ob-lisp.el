;;; ob-lisp.el --- org-babel functions for common lisp evaluation

;; Copyright (C) 2009, 2010, 2011  Free Software Foundation, Inc.

;; Author: Joel Boehland, Eric Schulte, David T. O'Toole <dto@gnu.org>
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 7.5

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; support for evaluating common lisp code, relies on slime for all eval

;;; Requirements:

;; Requires SLIME (Superior Lisp Interaction Mode for Emacs.)
;; See http://common-lisp.net/project/slime/

;;; Code:
(require 'ob)

(declare-function slime-eval "ext:slime" (sexp &optional package))

(add-to-list 'org-babel-tangle-lang-exts '("lisp" . "lisp"))

(defvar org-babel-default-header-args:lisp '())
(defvar org-babel-header-arg-names:lisp '(package))

(defun org-babel-expand-body:lisp (body params)
  "Expand BODY according to PARAMS, return the expanded body."
  (let* ((vars (mapcar #'cdr (org-babel-get-header params :var)))
	 (result-params (cdr (assoc :result-params params)))
	 (print-level nil) (print-length nil)
	 (body (org-babel-trim
		(if (> (length vars) 0)
		    (concat "(let ("
			    (mapconcat
			     (lambda (var)
			       (format "(%S (quote %S))" (car var) (cdr var)))
			     vars "\n      ")
			    ")\n" body ")")
		  (format "(progn %s)" body)))))
    (if (or (member "code" result-params)
	    (member "pp" result-params))
	(format "(pprint %s)" body)
      body)))

(defun org-babel-execute:lisp (body params)
  "Execute a block of Common Lisp code with Babel."
  (require 'slime)
  (with-temp-buffer
    (insert (org-babel-expand-body:lisp body params))
    ((lambda (result)
       (if (member "output" (cdr (assoc :result-params params)))
	   (car result)
	 (condition-case nil (read (cadr result)) (error (cadr result)))))
     (slime-eval `(swank:eval-and-grab-output
		   ,(buffer-substring-no-properties (point-min) (point-max)))
		 (cdr (assoc :package params))))))

(provide 'ob-lisp)

;; arch-tag: 18086168-009f-4947-bbb5-3532375d851d

;;; ob-lisp.el ends here
