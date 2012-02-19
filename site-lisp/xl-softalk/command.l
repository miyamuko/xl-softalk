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
  )

(in-package :xl-softalk)

(export '(*softalk-url*
          *softalk-directory*
          *softalk-exe*
          *softalkw-exe*

          *voice-quality*
          *volume*
          *speed*
          *library*
          *voice*
          *hide*
          ))

(defvar *softalk-url* "http://www35.atwiki.jp/softalk/")
(defvar *softalk-directory* (merge-pathnames "softalk"
                                             ;; softalk �� 32 bit �v���Z�X�Ȃ�� (x86) �D��
                                             (or (si:getenv "ProgramFiles(x86)")
                                                 (si:getenv "PROGRAMFILES"))))
(defvar *softalk-exe* "SofTalk.exe")
(defvar *softalkw-exe* "softalkw.exe")

;; - /P:�ǂ�
;;   �ǂ݁i�������j�E�P��E�S/���p����ʁiTrue/False�j���R���}��؂�Ŏw��
;;   /P:�Ă���,T��st,True
;;   �o�^�ς݂̒P��̏ꍇ�͈ȑO�̒P����X�V
;; - /Q:0�`4
;;   0:�������ϊ��E�}�g�i�p��ǂ݁j�Ȃ�
;;   1:�}�g�i�p��ǂ݁j�Ȃ�
;;   2:�������ϊ�����
;;   3:�������ϊ��E�}�g�i�p��ǂ݁j����
;;   �I�𒆂̃��C�u�����ɑ΂��Đݒ�
;; - /R:�p�X
;;   �ǂݏグ�����̘͂^��
;; - /S:1�`200
;;   �ǂݏグ���x
;; - /T:7�`10
;;   ���C�u�����i�G���W���j�̑I��
;; - /U:0�`?
;;   ���C�u�����i�G���W���j���琺��I�� �I�𒆂̃��C�u�����ɑ΂��Đݒ�
;; - /V:0�`100
;;   ����
;; - /W:����
;;   �ǂݏグ�������� ���̃I�v�V�����ȍ~�̕����͑S�ĕ��͂Ƃ݂Ȃ�
;; - /X:0�`1
;;   ��ʕ\��
;;   0:�\��
;;   1:��\��
;;   �N�����̂ݗL��
;; - /Z:
;;   �p�X
;;   �I���\�Ȑ���XML�`���ŏo��


(defvar *voice-quality* nil
  "������ 0-4 �Ŏw�� (/Q �I�v�V����)
0: �������ϊ��E�}�g�i�p��ǂ݁j�Ȃ�
1: �}�g�i�p��ǂ݁j�Ȃ�
2: �������ϊ�����
3: �������ϊ��E�}�g�i�p��ǂ݁j����")

(defvar *volume* 50
  "���ʂ� 0-100 �Ŏw�� (/V �I�v�V����)�B�f�t�H���g�� 50")

(defvar *speed* 100
  "�ǂݏグ���x�� 1-200 �Ŏw�� (/S �I�v�V����)�B�f�t�H���g�� 100")

(defvar *library* 7
  "���C�u������ 7-10 �Ŏw�� (/T �I�v�V����)�B�f�t�H���g�� 7")

(defvar *voice* 0
  "���C�u�����̐��� 0 �ȏ�Ŏw�� (/U �I�v�V����)�B�f�t�H���g�� 0")

(defvar *hide* t
  "nil �Ȃ��ʂ�\������ (/X �I�v�V����)�B�f�t�H���g�� t")


(defun options (&rest additional-options)
  (cons `("/X" ,(if *hide* 1 0))
        additional-options))

(defun voice-options (&rest additional-options)
  (let (r)
    (flet ((opt (k v)
             (when v
               (push (list k v) r))))
      (opt "/T" *library*)
      (opt "/U" *voice*)
      (opt "/Q" *voice-quality*)
      (opt "/V" *volume*)
      (opt "/S" *speed*))
    (apply #'options (append (nreverse r) additional-options))))

(defun command-option (opt now)
  (list (format nil "/~A~@[_now~]" opt now)))


(defun run (args &key wait (dir *softalk-directory*) softalkw)
  (let ((cmd (command-line (exe-path :dir dir :softalkw softalkw)
                           args)))
    (call-process cmd :wait wait)))

(defun command-line (exe args)
  (format nil "\"~A\" ~{~A~^ ~}"
          exe
          (mapcar #'(lambda (opt)
                      (etypecase opt
                        (string-designator (string opt))
                        (list (format nil "~{~A~^:~}" opt))))
                  args)))

(defun exe-path (&key (dir *softalk-directory*) softalkw)
  (let ((exe (if softalkw *softalkw-exe* *softalk-exe*)))
    (when dir
      (setf exe (merge-pathnames exe dir)))
    (map-slash-to-backslash (truename exe))))


(defun parse-voice-library (xml)
  (let (r)
    (dolist (line (split-string xml #\LFD))
      (cond ((string-matchp "<library opt=\"/T:\\(.+?\\)\" name=\"\\(.+?\\)\">" line)
             (push (list (cons (match-integer 1) (match-string 2))) r))
            ((string-matchp "<voice opt=\"/U:\\(.+?\\)\">\\(.+?\\)<" line)
             (push (cons (match-integer 1) (match-string 2)) (car r)))
            ))
    (mapcar #'nreverse (nreverse r))))


(provide "xl-softalk/command")