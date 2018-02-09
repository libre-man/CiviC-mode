;;; civic-mode.el --- Major mode for editing CiviC. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2018, Thomas Schaper

;; Version: 0.3.14
;; Author: Thomas Schaper (thomas@libremail.nl)
;; Keywords: languages
;; Created: 09-02-2018

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 3.

;;; Commentary:

;; This is a simple major mode to highlight CiviC code.

;;; Code:

(defvar civic-font-lock-keywords
  (let* (
         ;; define several category of keywords
         (keywords '("do" "else" "for" "if" "return" "while" "extern" "export"))
         (types '("int" "float" "bool" "void"))
         (constants '("true" "false"))
         (builtins '())
         (preprocessors '("include" "if" "ifdef" "ifndef" "endif" "else"))

         ;; generate regex string for each category of keywords
         (keywords-regexp (regexp-opt keywords 'words))
         (types-regexp (regexp-opt types 'words))
         (constants-regexp (regexp-opt constants 'words))
         (builtins-regexp (regexp-opt builtins 'words))
         (preprocessor-regexp (concat "#" (regexp-opt preprocessors 'words)))
         (functions-regexp (concat types-regexp " *\\([a-zA-z][a-zA-z0-9_]*(\\)"))
         (include-regexp "\\(#include\\) *\\(<.*?>\\)"))

    `((,types-regexp . font-lock-type-face)
      ;; This needs to be before keywords as #if and if clash.
      (,preprocessor-regexp . font-lock-preprocessor-face)
      (,constants-regexp . font-lock-constant-face)
      (,builtins-regexp . font-lock-builtin-face)
      (,functions-regexp . font-lock-function-name-face)
      (,keywords-regexp . font-lock-keyword-face)
      (,functions-regexp
       (1 font-lock-type-face)
       (2 font-lock-function-name-face))
      (,include-regexp
       (1 font-lock-preprocessor-face)
       (2 font-lock-string-face)))))

;;;###autoload
(define-derived-mode civic-mode c-mode "CiviC mode"
  "Major mode for editing CiviC code"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((civic-font-lock-keywords))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.civic$" . 'civic-mode))

;; add the mode to the `features' list
(provide 'civic-mode)

;;; civic-mode.el ends here
