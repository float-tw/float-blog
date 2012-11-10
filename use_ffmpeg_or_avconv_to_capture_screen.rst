使用 ffmpeg, avconv 做螢幕錄影
==============================


ffmpeg
======

::

    ffmpeg -f x11grab -r 25 -s 1366x768 -i :0.0 -sameq /tmp/out.mp4

avconv
======

::

    avconv -f x11grab -r 25 -s 1366x768 -i :0.0 -same_quant /tmp/test.mp4

說明
====

``f x11grab`` 從螢幕

``-r 25`` fps

``-s 1366x768`` 解析度

``-i :0.0`` 錄影的位置，可以用＋改變位置  ex. ``-i :0.0+10,20``

``-sameq`` & ``-same_quant`` 與來源使用相同的 quantizer，avconv 的 man page 說不等同於畫質

，只是不知道還有什麼方式來讓畫質變好 Orz

最後檔名為輸出的檔案，ctrl-c 停止錄影

參考資料
========

http://turanct.wordpress.com/2010/04/22/use-ffmpeg-to-capture-your-screen-on-ubuntu/
