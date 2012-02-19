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

(export '(speak
          speak-file
          speak-selection
          speak-region
          speak-buffer

          list-voice-library
          add-dictionary

          play
          stop
          pause
          resume
          next
          previous
          clear
          close
          ))

(defun speak (text)
  (interactive "sText: ")
  (run (voice-options `(/W ,text))))

(defun speak-file (file)
  (interactive "fFile: ")
  (speak (read-file-into-string file)))

(defun speak-selection ()
  (interactive)
  (when (get-selection-type)
    (selection-start-end (s e)
      (speak-region s e))))

(defun speak-region (s e)
  (interactive "r")
  (if (< e s) (rotatef s e))
  (let ((c (buffer-substring s e)))
    (speak c)))

(defun speak-buffer ()
  (interactive)
  (speak-region (point-min) (point-max)))

(defun list-voice-library ()
  (parse-voice-library
   (call-with-temp-file #'(lambda (tmp)
                            (run (options `(/Z ,tmp))
                                 :softalkw t :wait t))
                        :output t)))

(defun add-dictionary (keyword yomi &key (ignore-zenkaku-hankaku t))
  (let ((v (format nil "~A,~A,~:[True~;False~]" yomi keyword ignore-zenkaku-hankaku)))
    (run (options `(/P ,v)))))

(defun play (&key now) (run (command-option :play now)))
(defun stop (&key now) (run (command-option :stop now)))
(defun pause (&key now) (run (command-option :pause now)))
(defun resume (&key now) (run (command-option :resume now)))
(defun next (&key now) (run (command-option :next now)))
(defun previous (&key now) (run (command-option :previous now)))
(defun clear (&key now) (run (command-option :clear now)))
(defun close (&key now save) (run (command-option (if save :close :close2) now)))


(provide "xl-softalk/api")
