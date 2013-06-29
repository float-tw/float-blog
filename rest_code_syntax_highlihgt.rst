[reST] Code Syntax Highlight
============================

今天參加了 Tainan.py X MOSUT 的聚會，其中一個主題是 sphinx 的文件教學，

sphinx 的文件是用 reStructuredText 撰寫的，講者 demo 的時候剛好 demo 到了在 reST 裡面使用 code syntax highlight

當初要開始用 reST 寫部落格的時候也稍微作過一些功課，只是 syntax highlight 的部份沒有試出來，

今天聽完分享後在繼續查了些資料，我原本用來轉換的 rst2html 是 Docutils 所帶的，當使用 code-block 區塊的時候，像是::

    .. code-block:: c

        int main()
        {
            printf("hello\n");
            return 0;
        }

是會發生錯誤的::

    $ rst2html test.rst > test.html
    test.rst:1: (ERROR/3) Unknown directive type "code-block".

    .. code-block:: c

        int main()
        {
            printf("hello\n");
            return 0;
        }

接著找到\ 這篇_\ 發現 Docutils 0.9 的版本後就支援了 code-block 而 Ubuntu 12.04.2 所套件庫裡的 Docutils 卻是 0.8.1::

    $ rst2html --version
    rst2html (Docutils 0.8.1 [release], Python 2.7.3, on linux2)
 
.. _這篇: http://stackoverflow.com/questions/9807604/how-can-i-get-rst2html-py-to-include-the-css-for-syntax-highlighting

所以我就把他移除了（怒），接著從 pip 安裝 Docutils::

    $ sudo apt-get remove docutils
    $ sudo pip install docutils

目前 pip 上的 Docutils 是 0.10 版，趕快來試用一下

.. code-block:: c

    int main()
    {
        printf("hello\n");
        return 0;
    }

哈，太好了可以用了 :)
