[shell script] 列出所有檔案
===========================

今天要把一堆檔案轉檔，所以用了 avconv + shell script

首先要列出要轉檔的檔案，根據以前的印象我就這樣寫了

::

    for i in $(ls)
    do
        echo $i
    done

在一些情況下他應該可以正常運作，

可是...這些檔案有空白阿...所以變數 i 就會拿到不完整被空白分開的檔名。

網路上查到了一些用 ``find, print...`` 的解法，看起來都超複雜的...

最後找到了這個

::

    for i in *
    do
        echo
    done

原來可以這樣寫...太棒了！

參考資料
--------

http://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
