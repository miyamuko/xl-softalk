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
  (require "xl-softalk/utils")
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

(defun parse-voice-library (xml)
  (let (r)
    (flet ((matched ()
             (cons (match-integer 1) (zenkaku-to-hankaku-string (match-string 2)))))
      (dolist (line (split-string xml #\LFD))
        (cond ((string-matchp "<library opt=\"/T:\\(.+?\\)\" name=\"\\(.+?\\)\">" line)
               (push (list (matched)) r))
              ((string-matchp "<voice opt=\"/U:\\(.+?\\)\">\\(.+?\\)<" line)
               (push (matched) (car r)))
              ))
      (mapcar #'nreverse (nreverse r)))))


(defun select-voice-library (library voice)
  (when voice
    (find-voice (find-library library) voice)))

(defun find-library (library)
  (find-all-item library (list-voice-library) #'car))

(defun find-voice (library-voices voice)
  (let ((r (mapcan #'(lambda (library-voice)
                       (when-let (v (find-all-item voice (cdr library-voice) #'identity))
                         (list (cons (car library-voice) v))))
                   library-voices)))
    ;; r = ((library voices...) (library2 voices...) ...)
    (unless r
      (error "ライブラリが見つかりません: ~S~%候補:~%~A"
             voice (format-library-voices library-voices)))
    (when (or (< 1 (length r))
              (< 1 (length (cdar r))))
      (error "ライブラリの候補が複数見つかりました: ~S~%候補:~%~A"
             voice (format-library-voices r)))
    (values-list (car r))))

(defun find-all-item (item alist key)
  (labels ((f (item key test)
             (remove-if-not (curry test item)
                            alist
                            :key key)))
    (etypecase item
      (null alist)
      (symbol (find-all-item (string item) alist key))
      (string
       (setf item (zenkaku-to-hankaku-string item))
       (or (f item (compose #'cdr key) #'string-equal)
           (f item (compose #'cdr key) #'string-matchp)))
      (number (f item (compose #'car key) #'=))
      )))

(defun format-library-voices (library-voices)
  (with-output-to-string (s)
    (dolist (library-voice library-voices)
      (format s "  :library ~2D    ; ~A~%" (caar library-voice) (cdar library-voice))
      (dolist (voice (cdr library-voice))
        (format s "    :voice ~2D    ;   ~A~%" (car voice) (cdr voice))))))


(provide "xl-softalk/api")
