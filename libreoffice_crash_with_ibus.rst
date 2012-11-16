LibreOffice 打字時崩潰
======================

用 ibus 在 LibreOffice 打字時有時候 LibreOffice 就會崩潰了，

後來發現崩潰總是發生在，ibus 的輸出緩衝區滿了的時候，

第一個想到的作法就是去改 ibus 的緩衝區設定，

.. image:: https://github.com/a13524000/float-blog/raw/master/img/ibus_setting.jpeg

不過從這邊修改不知道什麼原因常常會自己又變回 4 或 8 之類得很小的數值，

另外找到了從 gconf-editor 設定的方式（不過限定於新酷音）

在這個項目下 desktop -> ibus -> engine -> Chewing -> maxChiSymbolLen

.. image:: https://github.com/a13524000/float-blog/raw/master/img/gconf_chewing_setting.jpeg

只是這種設定只是治標不治本，當打超出設定的緩衝區時還是會崩潰 Orz

參考資料
--------

http://dodgelin.blogspot.tw/2012/04/ibus-chewing.html

http://goo.gl/yvtvn
