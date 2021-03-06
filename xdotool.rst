xdotool
=======

原本希望找個程式幫我重複做幾個無聊的動作，

而一開始想到的東西是 sikuli_ ，而無奈他執行的時候一直 carsh，

另外花時間解決這個問題感覺不太符合效益，所以就找到了這個東西。

.. _sikuli: http://sikuli.org/

簡介
----

套件說明：simulate X11 keyboard/mouse input

也就是在 X Windows 下模擬鍵盤和滑鼠的輸入


安裝
----

ubuntu/debian

::

    sudo apt-get install xdotool

其他可以參考 `xdotool 的 project 頁面`_

.. _xdotool 的 project 頁面: http://www.semicomplete.com/projects/xdotool/

範例
----

鍵盤輸入 a
^^^^^^^^^^

::

    xdotool key a

按住 a 放開 a
^^^^^^^^^^^^^

::

    xdotool keydown a
    xdotool keyup a

滑鼠移動到 (100, 200) 的位置
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    xdotool mousemove 100 200

按下滑鼠左鍵（左鍵：1、滾輪：2、右鍵：3、滾輪上/下：4/5）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    xdotool click 1
 
按住滑鼠放開滑鼠
^^^^^^^^^^^^^^^^

::

    xdotool mousedown
    xdotool mouseup

取得目前滑鼠位置
^^^^^^^^^^^^^^^^

::

    xdotool getmouselocation

各個動作下還可以加上一些參數，下面一個 man page 裡的例子

送出 ctrl + c 到所有 title 是 'gdb' 的視窗中
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    xdotool search --name gdb key ctrl+c

比較詳細的資料可以參考 man page 中的說明

執行方式
--------

執行方式大概有下面幾種

直接下命令
^^^^^^^^^^

像上面範例中的作法一樣，直接在 CLI 上輸入

::

    xdotool click

從檔案中讀取指令
^^^^^^^^^^^^^^^^

::

    xdotool filename

從標準輸入（stdin）讀取
^^^^^^^^^^^^^^^^^^^^^^^

可以搭配 redirection 來從檔案中讀取

::

    xdotool -
    xdotool - < filename

寫成 script
^^^^^^^^^^^

::

    #!/usr/bin/xdotool
    
    mousemove 100 200
    click

其他
----

有一 xdotoolgui 的東西，似乎是可以直接用來編輯 xdotool 的命令，

不過我的需求沒有很複雜，而也他也不再套件庫中，所以我就沒有深入研究。


