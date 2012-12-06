find 和 xargs 包含空白
======================

某次剛好遇到想要計算 code 的總行數，

就下了這樣的指令，::

    find . -name "*.cpp" | xargs wc -l

在我的電腦上可以正常運作，只是在 `e0 <http://kuoe0.ch/>`_ 的電腦上不行，

研究了一下發現是因為檔名中有空白的問題，

找到了這個解法,::

    find . -name "*.cpp" -print0 | xargs -0 wc -l

``find`` 的 ``-print0`` 是將每個輸出的結尾加上 null，

``xargs`` 的 ``-0`` 則是將分隔的符號由空白改成 null

所以就可以解決 find 後檔名有空白的問題了。

參考資料
========

http://superuser.com/questions/275057/escape-files-output-for-compatibilty-with-xargs
