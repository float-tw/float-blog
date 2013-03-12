github push 時仍然需要帳號密碼
==============================

有一天在把改好的東西 push 到 github 上時發現還是需要輸入帳號密碼。

可是我已經將 public key 放到 github 上了，主機上也有對應的 private key，

而我在其他電腦上也作過相同的事，卻不需要帳號密碼。

找不到原因的情況下只好求助 CrBoy_ 大大，

經過大大的提點以後發現我的 remote url 所用的是 https 的而不是 ssh 的，

這應該是跟在 clone repo 時所使用的 url 有關。

其中一個修改方法是在 repo 中的 ``.git/config`` 裡修改，

::

    [remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    # ssh
    url = git@github.com:float-tw/float-blog
    # https
    url = https://github.com/float-tw/float-blog.git

將 url 的部份由 https 改為 ssh 就可以了，而 url 寫法可以在 github 的 repo 頁面找到。

.. _CrBoy: http://blog.crboy.net
