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

(export '(*softalk-help-chm*
          *softalk-home-page-url*

          open-help-file
          open-home-page
          ))

(defvar *softalk-help-chm* "help/help.chm"
  "SofTalk �̃w���v�t�@�C�����w��B�ʏ�͕ύX����K�v�Ȃ��B")

(defvar *softalk-home-page-url* "http://www35.atwiki.jp/softalk/"
  "SofTalk �̃z�[���y�[�W�� URL ���w��B�ʏ�͕ύX����K�v�Ȃ��B")

(defun open-help-file ()
  "SofTalk �̃w���v�t�@�C�����J���܂��B"
  (interactive)
  (let ((path (merge-pathnames *softalk-help-chm* *softalk-directory*)))
    (message "Open ~A" path)
    (shell-execute path)))

(defun open-home-page ()
  "SofTalk �̃z�[���y�[�W���f�t�H���g�u���E�U�ŊJ���܂��B"
  (interactive)
  (let ((url *softalk-url*))
    (message "Open ~A" url)
    (shell-execute url t)))


(provide "xl-softalk/misc")