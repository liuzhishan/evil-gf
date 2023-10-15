;;; evil-gf.el
;;;
;;; open-file-under-cursor for evil mode.
;;;
;;;-*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 liuzhishan
;;
;; Author: liuzhishan <liuzhishan01@gmail.com>
;; Maintainer: liuzhishan <liuzhishan01@gmail.com>
;; Created: October 16, 2023
;; Modified: October 16, 2023
;; Version: 0.0.1
;; Homepage: https://github.com/lzs/evil-gf
;; Package-Requires: ((emacs "24.4"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;;
;;; I found that `gf` command in evil mode doest work. So I wrote the following function
;;; to do the job. Just copy the following code to config.el and then you can you use `gf`
;;; just like in vim.
;;
;;; Code:
(defun evil-gf-open-file-under-cursor ()
  (interactive)
  (let ((file-path (thing-at-point 'filename t)))
    (if (file-name-absolute-p file-path)
        (find-file file-path)
      (let ((arr (split-string (buffer-file-name) "/"))
            (len-arr (number-sequence 1 (length arr)))
            (target-filename ""))
        (dolist (len (number-sequence 1 (length arr)) target-filename)
          (let ((new-filename (string-join (append (-take len arr) (list file-path)) "/")))
            (if (file-exists-p new-filename)
                (setq target-filename new-filename))
            ))

        (if (and (> (length target-filename) 5) (file-exists-p target-filename))
            (find-file target-filename)
          (message (format "file not exists: %s" file-path)))))))

(define-key evil-normal-state-map "gf" 'evil-gf-open-file-under-cursor)
