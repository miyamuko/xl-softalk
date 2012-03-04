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
  (require "xl-softalk/library")
  )

(in-package :xl-softalk)

(export '(speak
          speak-file
          speak-selection
          speak-region
          speak-buffer

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

(defun speak (text &key library voice quality volume speed)
  "TEXT を読み上げます。

* LIBRARY: ライブラリを指定します。VOICE も指定してください。
  デフォルトは *LIBRARY* です。
* VOICE: ライブラリの声を指定します。一意に特定出来る場合は LIBRARY は省略可能です。
  デフォルトは *VOICE* です。
* QUALITY: 声質を 0-4 で指定します。
  デフォルトは *QUALITY* です。
* VOLUME: 音量を 0-100 で指定します。
  デフォルトは *VOLUME* です。
* SPEED: 読み上げ速度を 1-200 で指定します。
  デフォルトは *SPEED* です。

LIBRARY および VOICE の指定は整数、文字列、シンボルで指定します。

* 整数で指定した場合はライブラリの ID でライブラリを探します。
  ライブラリの ID は LIST-VOICE-LIBRARY で確認できます。
* 文字列またはシンボルで指定した場合はライブラリ名でライブラリを探します。
  ライブラリ名は一意に特定出来るなら一部のみを指定しても構いません。

例:

  (softalk:speak \"こんにちは\")

  ;; 読み上げ速度、音量指定
  (softalk:speak \"こんにちは\" :speed 150 :volume 80)

  ;; ライブラリ ID 指定
  (softalk:speak \"hello\" :library 8 :voice 0)
  ;; ライブラリ名指定
  (softalk:speak \"hello\" :library \"SAPI\" :voice \"Microsoft Anna - English (United States)\")
  ;; 一意に特定出来るなら :library は省略可能
  (softalk:speak \"hello\" :voice \"Microsoft Anna - English (United States)\")
  ;; 一意に特定出来るならライブラリ名の一部のみを指定可能
  (softalk:speak \"hello\" :voice :anna)
"
  (interactive "sText: ")
  (when (and library (not voice))
    (error ":library のみの指定はできません。:voice も指定してください。"))
  (multiple-value-bind (library voice)
      (when voice
        (select-voice-library library voice))
    (let ((*library* (or (car library) *library*))
          (*voice* (or (car voice) *voice*))
          (*quality* (or quality *quality*))
          (*volume* (or volume *volume*))
          (*speed* (or speed *speed*)))
      (check-type text string)
      (check-type *library* (or null (integer 7 10)))
      (check-type *voice* (or null (integer 0 *)))
      (check-type *quality* (or null (integer 0 3)))
      (check-type *volume* (or null (integer 0 100)))
      (check-type *speed* (or null (integer 1 200)))
      (run (voice-options `(/W ,text))))))

(defun speak-file (file &rest args &key library voice quality volume speed)
  "FILE を読み上げます。

オプションの説明は SPEAK 関数を参照してください。"
  (interactive "fFile: ")
  (apply #'speak (read-file-into-string file) args))

(defun speak-selection (&rest args &key library voice quality volume speed)
  "選択範囲を読み上げます。

オプションの説明は SPEAK 関数を参照してください。"
  (interactive)
  (when (get-selection-type)
    (selection-start-end (start end)
      (apply #'speak (buffer-substring start end) args))))

(defun speak-region (start end &rest args &key library voice quality volume speed)
  "リージョンを読み上げます。

オプションの説明は SPEAK 関数を参照してください。"
  (interactive "r")
  (if (< end start) (rotatef start end))
  (apply #'speak (buffer-substring start end) args))

(defun speak-buffer ()
  "バッファを読み上げます。

オプションの説明は SPEAK 関数を参照してください。"
  (interactive)
  (speak-region (point-min) (point-max)))

(defun add-dictionary (keyword yomi &key (ignore-zenkaku-hankaku t))
"辞書に単語を追加します。

* KEYWORD: 単語を指定します（漢字や英単語など）
* YOMI: 読み上げ方をひらがなで指定します
* IGNORE-ZENKAKU-HANKAKU: 全角半角の区別を無視するなら t"
  (check-type keyword string)
  (check-type yomi string)
  (let ((v (format nil "~A,~A,~:[True~;False~]" yomi keyword ignore-zenkaku-hankaku)))
    (run (options `(/P ,v)))))

(defun play (&key now)
  "SofTalk に実行オプション (/play) を送信。

* NOW: non-nil を指定すると即時実行オプション (/play_now) を送信"
  (run (command-option :play now)))

(defun stop (&key now)
  "SofTalk に実行オプション (/stop) を送信。

* NOW: non-nil を指定すると即時実行オプション (/stop_now) を送信"
  (run (command-option :stop now)))

(defun pause (&key now)
  "SofTalk に実行オプション (/pause) を送信。

* NOW: non-nil を指定すると即時実行オプション (/pause_now) を送信"
  (run (command-option :pause now)))

(defun resume (&key now)
  "SofTalk に実行オプション (/resume) を送信。

* NOW: non-nil を指定すると即時実行オプション (/resume_now) を送信"
  (run (command-option :resume now)))

(defun next (&key now)
  "SofTalk に実行オプション (/next) を送信。

* NOW: non-nil を指定すると即時実行オプション (/next_now) を送信"
  (run (command-option :next now)))

(defun previous (&key now)
  "SofTalk に実行オプション (/previous) を送信。

* NOW: non-nil を指定すると即時実行オプション (/previous_now) を送信"
  (run (command-option :previous now)))

(defun clear (&key now)
  "SofTalk に実行オプション (/clear) を送信。

* NOW: non-nil を指定すると即時実行オプション (/clear_now) を送信"
  (run (command-option :clear now)))

(defun close (&key now save)
  "SofTalk に実行オプション (/close) を送信。

* NOW: non-nil を指定すると即時実行オプション (/close_now) を送信
* SAVE: non-nil を指定すると変更された設定を保存して SofTalk を終了 (/close2 または /close2_now)"
  (run (command-option (if save :close :close2) now)))


(provide "xl-softalk/api")
