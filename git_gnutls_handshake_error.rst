Git GnuTLS handshake error
==========================

在 Ubuntu 11.10, 12.04 底下用 git clone https 的 project 時看到了這個錯誤

``error: gnutls_handshake() failed: A TLS packet with unexpected length was received``

最簡單的解決方法是改用 http 就可以避開這個問題，

另外的解決方法是把 git 重新編譯，好像是因為 ubuntu 預設的 SSL 是使用 GnuTLS

而 GnuTLS 在處理某些網站的時候會有錯誤 [1]_ ，

重新編譯改用 OpenSSL 就可以解決這個問題，下面簡單的編譯流程，和我遇到的問題

首先先不要急著把你的 git 移除，先拿他來下載最新的 git source cdoe

git 官網提供的也是 https 的，自己把他改成 http

::

    $ git clone http://github.com/git/git.git

把 libcurl4-gnutls-dev 換成 libcurl4-openssl dev

::

    $ sudo apt-get install libcurl4-openssl-dev

這時候應該會順便把 libcurl4-gnutls-dev 移除，

同時也可以安裝一下編譯需要的程式、函式庫可以參考 git 資料夾下的 INSTALL 後半段，

或是編譯的時候在依照錯誤訊息去安裝。

編譯流程

::

    $ make configure
    $ ./configure
    $ make all doc
    # make inatll install-doc install-html

這邊我遇到的問題是，如果照著 INSTALL 裡的 ``$ ./configure --prefix=/usr``

編譯出來的程式還是有相同的問題，不要加或是用 ``--prefix=/usr/local`` 才行

要編譯 doc 的話要安裝 ASCIIDOC 而 doc 編譯的時間看起來比 git 本身還久 Orz

在 install 前可以先拿編譯完在 git 資料夾下的 git 測試看看，如果沒有相同的 error 後，

再把原本的 git 移除，移除後在以 root 安裝

參考資料
--------

http://d.hatena.ne.jp/komamitsu/20120619/1340117644

http://blog.carlcarl.tw/269/git-gnutls%E9%8C%AF%E8%AA%A4

.. [1] pycurl 好像也有類似問題

http://legnaleurc.blogspot.tw/2012/04/add-apt-repository-fails-with.html
