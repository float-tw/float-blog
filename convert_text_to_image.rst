[Convert] 將文字轉成圖片
========================

有時候在簡報或者寫 blog 時會有需要將一些輸出結果呈現出來的時候，

螢幕截圖是一個不錯的方式，不過截圖可能會比較模糊而且麻煩，

最近發現 convert 就有附帶一個功能是將文字直接轉換成圖片，用在這個地方剛剛好。

首先先舉個用 convert 將文字轉成圖片的例子::

    $ convert -size 64x32 label:float convert_label.jpeg

指定大小 64x32 文字內容為 float 就可以得到以下圖片

.. image:: https://github.com/float-tw/float-blog/raw/master/img/convert_label.jpeg

接下來要把 ``ifconfig lo`` 的結果轉換成圖片，首先先看一下原本的執行結果::

    $ ifconfig lo
    lo    Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:38990 errors:0 dropped:0 overruns:0 frame:0
          TX packets:38990 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:4280371 (4.2 MB)  TX bytes:4280371 (4.2 MB)
 
那我們可以用 pipe 導給 convert 將結果轉成圖片::

    $ ifconfig lo | convert label:@- convert_label_ifconfig.jpeg

``label:@-`` 的部份是表示 label 的內容由標準輸入取得，就可以得到

.. image:: https://github.com/float-tw/float-blog/raw/master/img/convert_label_ifconfig.jpeg

當然我們也可以指定圖片為黑底白字::

    $ ifconfig lo | convert -background black -fill white label:@- convert_label_ifconfig_black.jpeg

.. image:: https://github.com/float-tw/float-blog/raw/master/img/convert_label_ifconfig_black.jpeg

當然 label 在使用上還有很多參數可以使用，這部份可以參考這片 [#]_ 以及官方的範例 [#]_

參考資料
--------

.. [#] http://www.cnx-software.com/2011/09/22/how-to-convert-a-command-line-result-into-an-image-in-linux/

.. [#] http://www.imagemagick.org/Usage/text/
