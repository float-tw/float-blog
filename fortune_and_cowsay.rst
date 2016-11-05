無用系列 (1): fortune and cowsay
================================

.. image:: https://github.com/float-tw/float-blog/raw/master/img/fortune-cowsay/cowsay.png

cowsay
------

如文章一開頭的牛所示， cowsay 就是一頭牛在講話，

你可以這樣來個 cowsay 版的 hello world::

    $ cowsay "hello world"
    #or
    $ echo "hello world" | cowsay

當然如果你不喜歡牛牛，也可以來隻企鵝::

    $ echo "hi" | cowsay -f tux

.. image:: https://github.com/float-tw/float-blog/raw/master/img/fortune-cowsay/cowsay-tux.png

fortune
-------

fortune 可以印出一段諺語，像這樣::

    $ fortune
    Be careful of reading health books, you might die of a misprint.
            -- Mark Twain

也有中文版的，像是唐詩一類的，不過是簡體，搜尋 fortune 相關的套件就可以看到

應用
----

cowsay 的 wiki 頁面 [#]_ 就剛好拿了 fortune 和 cowsay 來做範例

把 fortune 的輸出送給 cowsay 就可以讓牛幫你講諺語了！::

    $ fortune | cowsay

.. image:: https://github.com/float-tw/float-blog/raw/master/img/fortune-cowsay/fortune-cowsay.png

我自己則是在 bashrc 裡面加了一段，讓 bash 開起來時請小企鵝說段話::

    echo -e "\e[s\e[3B"
    fortune | cowsay -f tux | awk 'BEGIN {FS="\n"} {printf "%30s%s\n", "",  $0}'
    echo -e "\e[u"                                                              

效果大概像這樣

.. image:: https://github.com/float-tw/float-blog/raw/master/img/fortune-cowsay/bash-tux.png
    :width: 600

參考資料
--------

.. [#] https://zh.wikipedia.org/wiki/Cowsay

.. [#] http://ithelp.ithome.com.tw/articles/10128193
