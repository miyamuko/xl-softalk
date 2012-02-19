# xl-softalk - SofTalk を使ってテキストの読み上げ (TTS)

* Home URL: http://miyamuko.s56.xrea.com/xyzzy/xl-softalk/intro.htm
* Version: 0.0.1


## SYNOPSIS

### API

```lisp
;;; xyzzy lisp REPL
user> (require "xl-softalk")
t

user> (softalk:speak "xyzzy はテキストエディタのようなものです。")
t

user> (softalk:list-voice-library)
(((7 . "AquesTalk") (0 . "女性１") (1 . "女性２") (2 . "男性１") (3 . "男性２") (4 . "ロボット") (5 . "中性") (6 . "機械") (7 . "特殊"))
 ((8 . "SAPI") (0 . "Microsoft Anna - English (United States)"))
 ((9 . "Speech Platform") (0 . "Microsoft Server Speech Text to Speech Voice (ja-JP, Haruka)"))
 ((10 . "AquesTalk2") (0 . "aq_defo1.phont") (1 . "aq_f1b.phont") (2 . "aq_f1c.phont") (3 . "aq_huskey.phont") (4 . "aq_m3.phont") (5 . "aq_m4.phont") (6 . "aq_momo1.phont") (7 . "aq_rb2.phont") (8 . "aq_rm.phont") (9 . "aq_robo.phont") (10 . "aq_teto1.phont") (11 . "aq_yukkuri.phont"))
 )

user> (softalk:add-dictionary "xyzzy" "くさいじじい")
t

user> (let ((softalk:*volume* (* softalk:*volume* 1.2))
            (softalk:*speed* (* softalk:*speed* 0.5))
            (softalk:*library* 8)
            (softalk:*voice* 0))
        (softalk:speak "xyzzy はテキストエディタのようなものです。"))
t

user> (softalk:stop :now t)
t

user> (softalk:close :now t)
t
```

### コマンド

```
M-x softalk:speak
M-x softalk:speak-selection
M-x softalk:speak-region
M-x softalk:speak-buffer
```


## DESCRIPTION

xl-softalk は [SofTalk] を利用して xyzzy でテキストの読み上げを行うツールです。

xl-softalk でゆっくりしていってね！

  [SofTalk]: http://www35.atwiki.jp/softalk/


## INSTALL

1. [NetInstaller] で xl-softalk, xl-alexandria, ansify, ansi-loop, setf-values
   をインストールします。

2. ni-autoload を利用していない場合は、
   ~/.xyzzy または site-lisp/siteinit.l に以下のコードを追加します。

    ```lisp
    (require "xl-softalk")
    ```

    ※ ni-autoload を利用している場合は設定は不要です。

3. 設定を反映させるため xyzzy を再起動してください。

     ※siteinit.l に記述した場合には再ダンプが必要です。

4. [SofTalk] をインストールして、インストール先を `softalk:*softalk-directory*` に設定します。

    ```lisp
    ;; デフォルト値は以下のどちらかなので、それ以外にインストールした場合は設定が必要。
    ;; - c:/Program Files/softalk              (32bit 版 OS の場合)
    ;; - c:/Program Files (x86)/softalk        (64bit 版 OS の場合)
    (setf softalk:*softalk-directory* "c:/Tools/softalk")
    ```

  [NetInstaller]: http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html
  [SofTalk]: http://www35.atwiki.jp/softalk/


## TODO

なし。


## KNOWN BUGS

  * SofTalk が起動していない状態で `(softalk:stop)` とかすると
    SofTalk が起動して画面が表示される。


要望やバグは [GitHub Issues] か [@miyamuko] まで。

  [GitHub Issues]: http://github.com/miyamuko/xl-softalk/issues
  [@miyamuko]: http://twitter.com/home?status=%40miyamuko%20%23xyzzy%20xl-softalk%3a%20


## AUTHOR

みやむこ かつゆき (<mailto:miyamuko@gmail.com>)


## COPYRIGHT

xl-softalk は MIT/X ライセンスに従って本ソフトウェアを使用、再頒布することができます。

    Copyright (c) 2012 MIYAMUKO Katsuyuki.

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
