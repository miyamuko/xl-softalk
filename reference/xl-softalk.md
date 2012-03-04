# xl-softalk API Reference

  * [Packages](#packages)
    * [xl-softalk](#package-xl-softalk)
  * [Variables](#variables)
    * [\*hide\*](#variable--hide-)
    * [\*library\*](#variable--library-)
    * [\*quality\*](#variable--quality-)
    * [\*softalk-directory\*](#variable--softalk-directory-)
    * [\*softalk-exe\*](#variable--softalk-exe-)
    * [\*softalk-help-chm\*](#variable--softalk-help-chm-)
    * [\*softalk-home-page-url\*](#variable--softalk-home-page-url-)
    * [\*softalkw-exe\*](#variable--softalkw-exe-)
    * [\*speed\*](#variable--speed-)
    * [\*voice\*](#variable--voice-)
    * [\*volume\*](#variable--volume-)
  * [Functions](#functions)
    * [clear](#function-clear)
    * [close](#function-close)
    * [list-voice-library](#function-list-voice-library)
    * [next](#function-next)
    * [pause](#function-pause)
    * [play](#function-play)
    * [previous](#function-previous)
    * [resume](#function-resume)
    * [stop](#function-stop)
    * [xl-softalk-version](#function-xl-softalk-version)
  * [Commands](#commands)
    * [add-dictionary](#command-add-dictionary)
    * [open-help-file](#command-open-help-file)
    * [open-home-page](#command-open-home-page)
    * [speak](#command-speak)
    * [speak-buffer](#command-speak-buffer)
    * [speak-file](#command-speak-file)
    * [speak-region](#command-speak-region)
    * [speak-selection](#command-speak-selection)

----

## <a name="packages">PACKAGES</a>

### Package: <a name="package-xl-softalk"><em>xl-softalk</em></a>

このパッケージは、SofTalk コマンドを実行するための簡単な API を提供します。

ニックネームは以下のとおりです。

  * `softalk`


----

## <a name="variables">VARIABLES</a>

### Variable: <a name="variable--hide-"><em>\*hide\*</em></a>

nil なら画面を表示する (/X オプション)。デフォルトは t


### Variable: <a name="variable--library-"><em>\*library\*</em></a>

ライブラリを 7-10 で指定 (/T オプション)。デフォルトは 7


### Variable: <a name="variable--quality-"><em>\*quality\*</em></a>

声質を 0-4 で指定 (/Q オプション)。デフォルトは指定なし

* 0: 平仮名変換・抑揚（英語読み）なし
* 1: 抑揚（英語読み）なし
* 2: 平仮名変換あり
* 3: 平仮名変換・抑揚（英語読み）あり


### Variable: <a name="variable--softalk-directory-"><em>\*softalk-directory\*</em></a>

SofTalk のインストールディレクトリを指定。

デフォルト値は以下のどちらかなので、それ以外にインストールした場合は設定が必要。

* c:/Program Files/softalk              (32bit 版 OS の場合)
* c:/Program Files (x86)/softalk        (64bit 版 OS の場合)


### Variable: <a name="variable--softalk-exe-"><em>\*softalk-exe\*</em></a>

SofTalk.exe のコマンド名を指定。通常は変更する必要なし。


### Variable: <a name="variable--softalk-help-chm-"><em>\*softalk-help-chm\*</em></a>

SofTalk のヘルプファイルを指定。通常は変更する必要なし。


### Variable: <a name="variable--softalk-home-page-url-"><em>\*softalk-home-page-url\*</em></a>

SofTalk のホームページの `URL` を指定。通常は変更する必要なし。


### Variable: <a name="variable--softalkw-exe-"><em>\*softalkw-exe\*</em></a>

softalkw.exe のコマンド名を指定。通常は変更する必要なし。


### Variable: <a name="variable--speed-"><em>\*speed\*</em></a>

読み上げ速度を 1-200 で指定 (/S オプション)。デフォルトは 100


### Variable: <a name="variable--voice-"><em>\*voice\*</em></a>

ライブラリの声を 0 以上で指定 (/U オプション)。デフォルトは 0


### Variable: <a name="variable--volume-"><em>\*volume\*</em></a>

音量を 0-100 で指定 (/V オプション)。デフォルトは 50


----

## <a name="functions">FUNCTIONS</a>

### Function: <a name="function-clear"><em>clear</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/clear) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/clear_now) を送信


### Function: <a name="function-close"><em>close</em></a> <i>&key `NOW` `SAVE`</i>

SofTalk に実行オプション (/close) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/close_now) を送信
* `SAVE`: non-nil を指定すると変更された設定を保存して SofTalk を終了 (/close2 または /close2_now)


### Function: <a name="function-list-voice-library"><em>list-voice-library</em></a> <i>&key `RELOAD`</i>

音声ライブラリをリストで返します。

音声ライブラリのリストは以下の形式です。


```lisp
(((<library1 id> . <library1 name>) (<voice1 id> . <voice1 name>) (<voice2 id> . <voice2 name>) ...)
 ((<library2 id> . <library2 name>) (<voice1 id> . <voice1 name>) (<voice2 id> . <voice2 name>) ...)
 ...)
```


SofTalk から取得したライブラリのリストは内部でキャッシュしています。
新たに音声ライブラリをインストールした場合は `RELOAD` に non-nil を指定して実行してください。


### Function: <a name="function-next"><em>next</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/next) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/next_now) を送信


### Function: <a name="function-pause"><em>pause</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/pause) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/pause_now) を送信


### Function: <a name="function-play"><em>play</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/play) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/play_now) を送信


### Function: <a name="function-previous"><em>previous</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/previous) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/previous_now) を送信


### Function: <a name="function-resume"><em>resume</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/resume) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/resume_now) を送信


### Function: <a name="function-stop"><em>stop</em></a> <i>&key `NOW`</i>

SofTalk に実行オプション (/stop) を送信。

* `NOW`: non-nil を指定すると即時実行オプション (/stop_now) を送信


### Function: <a name="function-xl-softalk-version"><em>xl-softalk-version</em></a>

xl-softalk のバージョンを返します。
SofTalk 本体のバージョンではありません。


----

## <a name="commands">COMMANDS</a>

### Command: <a name="command-add-dictionary"><em>add-dictionary</em></a> <i>`YOMI` `WORD` &optional (`ZENKAKU-HANKAKU-SENSITIVE` *prefix-args*)</i>

辞書に単語を追加します。

* `YOMI`: 読み方をひらがなで指定します
* `WORD`: 単語を指定します（漢字や英単語など）
* `ZENKAKU-HANKAKU-SENSITIVE`: 全角半角を区別するなら t。
   デフォルトは前置引数なしだと nil、前置引数ありだと t


### Command: <a name="command-open-help-file"><em>open-help-file</em></a>

SofTalk のヘルプファイルを開きます。


### Command: <a name="command-open-home-page"><em>open-home-page</em></a>

SofTalk のホームページをデフォルトブラウザで開きます。


### Command: <a name="command-speak"><em>speak</em></a> <i>`TEXT` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

`TEXT` を読み上げます。

* `LIBRARY`: ライブラリを指定します。`VOICE` も指定してください。
   デフォルトは [\*library\*](#variable--library-) です。
* `VOICE`: ライブラリの声を指定します。一意に特定出来る場合は `LIBRARY` は省略可能です。
   デフォルトは [\*voice\*](#variable--voice-) です。
* `QUALITY`: 声質を 0-4 で指定します。
   デフォルトは [\*quality\*](#variable--quality-) です。
* `VOLUME`: 音量を 0-100 で指定します。
   デフォルトは [\*volume\*](#variable--volume-) です。
* `SPEED`: 読み上げ速度を 1-200 で指定します。
   デフォルトは [\*speed\*](#variable--speed-) です。

`LIBRARY` および `VOICE` の指定は整数、文字列、シンボルで指定します。

* 整数で指定した場合はライブラリの ID でライブラリを探します。
   ライブラリの ID は [list-voice-library](#function-list-voice-library) で確認できます。
* 文字列またはシンボルで指定した場合はライブラリ名でライブラリを探します。
   ライブラリ名は一意に特定出来るなら一部のみを指定しても構いません。

例:


```lisp
(softalk:speak "こんにちは")

;; 読み上げ速度、音量指定
(softalk:speak "こんにちは" :speed 150 :volume 80)

;; ライブラリ ID 指定
(softalk:speak "hello" :library 8 :voice 0)
;; ライブラリ名指定
(softalk:speak "hello" :library "SAPI" :voice "Microsoft Anna - English (United States)")
;; 一意に特定出来るなら :library は省略可能
(softalk:speak "hello" :voice "Microsoft Anna - English (United States)")
;; 一意に特定出来るならライブラリ名の一部のみを指定可能
(softalk:speak "hello" :voice :anna)
```


### Command: <a name="command-speak-buffer"><em>speak-buffer</em></a>

バッファを読み上げます。

オプションの説明は [speak](#command-speak) 関数を参照してください。


### Command: <a name="command-speak-file"><em>speak-file</em></a> <i>`FILE` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

`FILE` を読み上げます。

オプションの説明は [speak](#command-speak) 関数を参照してください。


### Command: <a name="command-speak-region"><em>speak-region</em></a> <i>`START` `END` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

リージョンを読み上げます。

オプションの説明は [speak](#command-speak) 関数を参照してください。


### Command: <a name="command-speak-selection"><em>speak-selection</em></a> <i>`START` `END` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

選択範囲を読み上げます。

オプションの説明は [speak](#command-speak) 関数を参照してください。

