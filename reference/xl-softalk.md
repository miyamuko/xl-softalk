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

���̃p�b�P�[�W�́ASofTalk �R�}���h�����s���邽�߂̊ȒP�� API ��񋟂��܂��B

�j�b�N�l�[���͈ȉ��̂Ƃ���ł��B

  * `softalk`


----

## <a name="variables">VARIABLES</a>

### Variable: <a name="variable--hide-"><em>\*hide\*</em></a>

nil �Ȃ��ʂ�\������ (/X �I�v�V����)�B�f�t�H���g�� t


### Variable: <a name="variable--library-"><em>\*library\*</em></a>

���C�u������ 7-10 �Ŏw�� (/T �I�v�V����)�B�f�t�H���g�� 7


### Variable: <a name="variable--quality-"><em>\*quality\*</em></a>

������ 0-4 �Ŏw�� (/Q �I�v�V����)�B�f�t�H���g�͎w��Ȃ�

* 0: �������ϊ��E�}�g�i�p��ǂ݁j�Ȃ�
* 1: �}�g�i�p��ǂ݁j�Ȃ�
* 2: �������ϊ�����
* 3: �������ϊ��E�}�g�i�p��ǂ݁j����


### Variable: <a name="variable--softalk-directory-"><em>\*softalk-directory\*</em></a>

SofTalk �̃C���X�g�[���f�B���N�g�����w��B

�f�t�H���g�l�͈ȉ��̂ǂ��炩�Ȃ̂ŁA����ȊO�ɃC���X�g�[�������ꍇ�͐ݒ肪�K�v�B

* c:/Program Files/softalk              (32bit �� OS �̏ꍇ)
* c:/Program Files (x86)/softalk        (64bit �� OS �̏ꍇ)


### Variable: <a name="variable--softalk-exe-"><em>\*softalk-exe\*</em></a>

SofTalk.exe �̃R�}���h�����w��B�ʏ�͕ύX����K�v�Ȃ��B


### Variable: <a name="variable--softalk-help-chm-"><em>\*softalk-help-chm\*</em></a>

SofTalk �̃w���v�t�@�C�����w��B�ʏ�͕ύX����K�v�Ȃ��B


### Variable: <a name="variable--softalk-home-page-url-"><em>\*softalk-home-page-url\*</em></a>

SofTalk �̃z�[���y�[�W�� `URL` ���w��B�ʏ�͕ύX����K�v�Ȃ��B


### Variable: <a name="variable--softalkw-exe-"><em>\*softalkw-exe\*</em></a>

softalkw.exe �̃R�}���h�����w��B�ʏ�͕ύX����K�v�Ȃ��B


### Variable: <a name="variable--speed-"><em>\*speed\*</em></a>

�ǂݏグ���x�� 1-200 �Ŏw�� (/S �I�v�V����)�B�f�t�H���g�� 100


### Variable: <a name="variable--voice-"><em>\*voice\*</em></a>

���C�u�����̐��� 0 �ȏ�Ŏw�� (/U �I�v�V����)�B�f�t�H���g�� 0


### Variable: <a name="variable--volume-"><em>\*volume\*</em></a>

���ʂ� 0-100 �Ŏw�� (/V �I�v�V����)�B�f�t�H���g�� 50


----

## <a name="functions">FUNCTIONS</a>

### Function: <a name="function-clear"><em>clear</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/clear) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/clear_now) �𑗐M


### Function: <a name="function-close"><em>close</em></a> <i>&key `NOW` `SAVE`</i>

SofTalk �Ɏ��s�I�v�V���� (/close) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/close_now) �𑗐M
* `SAVE`: non-nil ���w�肷��ƕύX���ꂽ�ݒ��ۑ����� SofTalk ���I�� (/close2 �܂��� /close2_now)


### Function: <a name="function-list-voice-library"><em>list-voice-library</em></a> <i>&key `RELOAD`</i>

�������C�u���������X�g�ŕԂ��܂��B

�������C�u�����̃��X�g�͈ȉ��̌`���ł��B


```lisp
(((<library1 id> . <library1 name>) (<voice1 id> . <voice1 name>) (<voice2 id> . <voice2 name>) ...)
 ((<library2 id> . <library2 name>) (<voice1 id> . <voice1 name>) (<voice2 id> . <voice2 name>) ...)
 ...)
```


SofTalk ����擾�������C�u�����̃��X�g�͓����ŃL���b�V�����Ă��܂��B
�V���ɉ������C�u�������C���X�g�[�������ꍇ�� `RELOAD` �� non-nil ���w�肵�Ď��s���Ă��������B


### Function: <a name="function-next"><em>next</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/next) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/next_now) �𑗐M


### Function: <a name="function-pause"><em>pause</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/pause) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/pause_now) �𑗐M


### Function: <a name="function-play"><em>play</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/play) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/play_now) �𑗐M


### Function: <a name="function-previous"><em>previous</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/previous) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/previous_now) �𑗐M


### Function: <a name="function-resume"><em>resume</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/resume) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/resume_now) �𑗐M


### Function: <a name="function-stop"><em>stop</em></a> <i>&key `NOW`</i>

SofTalk �Ɏ��s�I�v�V���� (/stop) �𑗐M�B

* `NOW`: non-nil ���w�肷��Ƒ������s�I�v�V���� (/stop_now) �𑗐M


### Function: <a name="function-xl-softalk-version"><em>xl-softalk-version</em></a>

xl-softalk �̃o�[�W������Ԃ��܂��B
SofTalk �{�̂̃o�[�W�����ł͂���܂���B


----

## <a name="commands">COMMANDS</a>

### Command: <a name="command-add-dictionary"><em>add-dictionary</em></a> <i>`YOMI` `WORD` &optional (`ZENKAKU-HANKAKU-SENSITIVE` *prefix-args*)</i>

�����ɒP���ǉ����܂��B

* `YOMI`: �ǂݕ����Ђ炪�ȂŎw�肵�܂�
* `WORD`: �P����w�肵�܂��i������p�P��Ȃǁj
* `ZENKAKU-HANKAKU-SENSITIVE`: �S�p���p����ʂ���Ȃ� t�B
   �f�t�H���g�͑O�u�����Ȃ����� nil�A�O�u�������肾�� t


### Command: <a name="command-open-help-file"><em>open-help-file</em></a>

SofTalk �̃w���v�t�@�C�����J���܂��B


### Command: <a name="command-open-home-page"><em>open-home-page</em></a>

SofTalk �̃z�[���y�[�W���f�t�H���g�u���E�U�ŊJ���܂��B


### Command: <a name="command-speak"><em>speak</em></a> <i>`TEXT` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

`TEXT` ��ǂݏグ�܂��B

* `LIBRARY`: ���C�u�������w�肵�܂��B`VOICE` ���w�肵�Ă��������B
   �f�t�H���g�� [\*library\*](#variable--library-) �ł��B
* `VOICE`: ���C�u�����̐����w�肵�܂��B��ӂɓ���o����ꍇ�� `LIBRARY` �͏ȗ��\�ł��B
   �f�t�H���g�� [\*voice\*](#variable--voice-) �ł��B
* `QUALITY`: ������ 0-4 �Ŏw�肵�܂��B
   �f�t�H���g�� [\*quality\*](#variable--quality-) �ł��B
* `VOLUME`: ���ʂ� 0-100 �Ŏw�肵�܂��B
   �f�t�H���g�� [\*volume\*](#variable--volume-) �ł��B
* `SPEED`: �ǂݏグ���x�� 1-200 �Ŏw�肵�܂��B
   �f�t�H���g�� [\*speed\*](#variable--speed-) �ł��B

`LIBRARY` ����� `VOICE` �̎w��͐����A������A�V���{���Ŏw�肵�܂��B

* �����Ŏw�肵���ꍇ�̓��C�u������ ID �Ń��C�u������T���܂��B
   ���C�u������ ID �� [list-voice-library](#function-list-voice-library) �Ŋm�F�ł��܂��B
* ������܂��̓V���{���Ŏw�肵���ꍇ�̓��C�u�������Ń��C�u������T���܂��B
   ���C�u�������͈�ӂɓ���o����Ȃ�ꕔ�݂̂��w�肵�Ă��\���܂���B

��:


```lisp
(softalk:speak "����ɂ���")

;; �ǂݏグ���x�A���ʎw��
(softalk:speak "����ɂ���" :speed 150 :volume 80)

;; ���C�u���� ID �w��
(softalk:speak "hello" :library 8 :voice 0)
;; ���C�u�������w��
(softalk:speak "hello" :library "SAPI" :voice "Microsoft Anna - English (United States)")
;; ��ӂɓ���o����Ȃ� :library �͏ȗ��\
(softalk:speak "hello" :voice "Microsoft Anna - English (United States)")
;; ��ӂɓ���o����Ȃ烉�C�u�������̈ꕔ�݂̂��w��\
(softalk:speak "hello" :voice :anna)
```


### Command: <a name="command-speak-buffer"><em>speak-buffer</em></a>

�o�b�t�@��ǂݏグ�܂��B

�I�v�V�����̐����� [speak](#command-speak) �֐����Q�Ƃ��Ă��������B


### Command: <a name="command-speak-file"><em>speak-file</em></a> <i>`FILE` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

`FILE` ��ǂݏグ�܂��B

�I�v�V�����̐����� [speak](#command-speak) �֐����Q�Ƃ��Ă��������B


### Command: <a name="command-speak-region"><em>speak-region</em></a> <i>`START` `END` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

���[�W������ǂݏグ�܂��B

�I�v�V�����̐����� [speak](#command-speak) �֐����Q�Ƃ��Ă��������B


### Command: <a name="command-speak-selection"><em>speak-selection</em></a> <i>`START` `END` &rest `ARGS` &key `LIBRARY` `VOICE` `QUALITY` `VOLUME` `SPEED`</i>

�I��͈͂�ǂݏグ�܂��B

�I�v�V�����̐����� [speak](#command-speak) �֐����Q�Ƃ��Ă��������B

