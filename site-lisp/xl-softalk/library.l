; -*- mode: lisp; package: xl-softalk; encoding: shift_jis -*-

;; Copyright (c) 2012 MIYAMUKO Katsuyuki.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-softalk/package")
  (require "xl-softalk/command")
  )

(in-package :xl-softalk)

(export '(list-voice-library
          ))

(defparameter *voice-library-cache* nil)

(defun list-voice-library (&key reload)
  (when (or reload (not *voice-library-cache*))
    (setf *voice-library-cache*
          (parse-voice-library
           (call-with-temp-file #'(lambda (tmp)
                                    (run (options `(/Z ,tmp))
                                         :softalkw t :wait t))
                                :output t))))
  (copy-tree *voice-library-cache*))

(defun select-voice-library (library voice)
  (let* ((library-voice (find-library library))
         (voice (find-voice (cdr library-voice) voice)))
    (values (car library-voice) voice)))

(defun find-library (library)
  (find-all-item library (list-voice-library) #'car "ライブラリ"))

(defun find-voice (library-voice voice)
  (find-all-item voice library-voice #'identity "ライブラリの声"))

(defun find-all-item (item alist key name)
  (let ((r (find-all-item0 item alist key)))
    (unless r
      (error "~Aが見つかりません: ~S~%候補: ~S"
             name item (mapcar key alist)))
    (when (< 1 (length r))
      (error "~Aの候補が複数見つかりました: ~S~%候補: ~S"
             name item (mapcar key r)))
    (car r)))

(defun find-all-item0 (item alist key)
  (labels ((f (key test)
             (remove-if-not (curry test item)
                            alist
                            :key key)))
    (etypecase item
      (symbol (find-all-item0 (string item) alist key))
      (string (or (f (compose #'cdr key) #'string-equal)
                  (f (compose #'cdr key) #'string-matchp)))
      (number (f (compose #'car key) #'=))
      )))


(provide "xl-softalk/api")
