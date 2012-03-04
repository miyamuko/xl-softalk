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

          *quality*
          *volume*
          *speed*
          *library*
          *voice*
          *hide*
          ))

(defvar *softalk-url* "http://www35.atwiki.jp/softalk/")
(defvar *softalk-directory* (merge-pathnames "softalk"
                                             ;; softalk は 32 bit プロセスなんで (x86) 優先
                                             (or (si:getenv "ProgramFiles(x86)")
                                                 (si:getenv "PROGRAMFILES"))))
(defvar *softalk-exe* "SofTalk.exe")
(defvar *softalkw-exe* "softalkw.exe")

;; - /P:読み
;;   読み（平仮名）・単語・全/半角を区別（True/False）をコンマ区切りで指定
;;   /P:てすと,Tｅst,True
;;   登録済みの単語の場合は以前の単語を更新
;; - /Q:0～4
;;   0:平仮名変換・抑揚（英語読み）なし
;;   1:抑揚（英語読み）なし
;;   2:平仮名変換あり
;;   3:平仮名変換・抑揚（英語読み）あり
;;   選択中のライブラリに対して設定
;; - /R:パス
;;   読み上げた文章の録音
;; - /S:1～200
;;   読み上げ速度
;; - /T:7～10
;;   ライブラリ（エンジン）の選択
;; - /U:0～?
;;   ライブラリ（エンジン）から声を選択 選択中のライブラリに対して設定
;; - /V:0～100
;;   音量
;; - /W:文章
;;   読み上げたい文章 このオプション以降の文字は全て文章とみなす
;; - /X:0～1
;;   画面表示
;;   0:表示
;;   1:非表示
;;   起動時のみ有効
;; - /Z:
;;   パス
;;   選択可能な声をXML形式で出力


(defvar *quality* nil
  "声質を 0-4 で指定 (/Q オプション)。デフォルトは指定なし
0: 平仮名変換・抑揚（英語読み）なし
1: 抑揚（英語読み）なし
2: 平仮名変換あり
3: 平仮名変換・抑揚（英語読み）あり")

(defvar *volume* 50
  "音量を 0-100 で指定 (/V オプション)。デフォルトは 50")

(defvar *speed* 100
  "読み上げ速度を 1-200 で指定 (/S オプション)。デフォルトは 100")

(defvar *library* 7
  "ライブラリを 7-10 で指定 (/T オプション)。デフォルトは 7")

(defvar *voice* 0
  "ライブラリの声を 0 以上で指定 (/U オプション)。デフォルトは 0")

(defvar *hide* t
  "nil なら画面を表示する (/X オプション)。デフォルトは t")


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
      (opt "/Q" *quality*)
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


(provide "xl-softalk/command")
