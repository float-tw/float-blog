Run B2G on Desktop
==================

如果想玩玩看 B2G 卻沒有手機怎麼辦？

沒關係，在電腦上玩，除了使用模擬器以外還有例外的選擇，

其中一個是編譯一份電腦上可以跑的 B2G 。

環境
----

我所使用的環境是 Ubuntu 12.04 LTS x86_64

download source
---------------

要在電腦上跑起 B2G 需要兩個部份，

一個是 B2G 的主程式，另一個是 gaia 也就是 B2G 的使用者界面。

::

    $ hg clone http://hg.mozilla.org/mozilla-central
    $ git clone https://github.com/mozilla-b2g/gaia.git

build
-----

B2G
+++

B2G 的部份我們需要先建立一個設定檔 ``.mozconfig``

下面是我所使用的設定

::

    mk_add_options MOZ_MAKE_FLAGS="-j6"
    mk_add_options MOZ_OBJDIR=../build

    ac_add_options --enable-application=b2g
    ac_add_options --enable-debug
    ac_add_options --enable-profiling
    ac_add_options --with-ccache=/usr/bin/ccache


``MOZ_OBJDIR`` 的部份是設定編譯後檔案存放的位置，不指定的話會放在 mozilla-central 下的 obj-xxxxx

``MOZ_MAKE_FLAGS`` 設定編譯的參數， -j 接的數字是同時執行的 jobs 數量，適當調整可以加快編譯的速度

``--enable-application=b2g`` 這邊設定所要編譯的程式（ mozilla-central 包含了 Firefox, Thunderbird, B2G 等）

``--with-ccache=/usr/bin/ccache`` 是使用 ccahe 來加快編譯，詳細內容可以參考 這篇_

.. _這篇: https://developer.mozilla.org/en/ccache

寫完設定檔後就可以開始編譯了，Makefile 是 ``client.mk``

::

    $ make -f client.mk

整個編譯的過程需要大約半小時左右吧，另外如果有缺少編譯需要的套件，

就安裝一下吧，我是沒遇到，大概裝了太多東西了....

gaia
++++

編譯 gaia 前呢先設定兩個環境變數，一個是 gaia repo 的位置，

另一個就跟他的名稱一樣是 gaia 的 domain

::

    $ GAIA=PATH_TO_GAIA_REPOSITORY
    $ GAIA_DOMAIN=gaiamobile.org

接下來就可以編譯了

::

    $ DEBUG=1 make

DEBUG=1 可加可不加，主要就是影響一些 debug 訊息

執行
----

完成 B2G 和 gaia 的編譯以後就可以執行了！

不過在執行前先設定一下 ``/etc/hosts`` 在裡面加上

::

   127.0.0.1     gaiamobile.org 
   127.0.0.1     homescreen.gaiamobile.org
   127.0.0.1     dialer.gaiamobile.org 
   127.0.0.1     sms.gaiamobile.org 
   127.0.0.1     browser.gaiamobile.org 
   127.0.0.1     maps.gaiamobile.org 
   127.0.0.1     camera.gaiamobile.org
   127.0.0.1     gallery.gaiamobile.org
   127.0.0.1     video.gaiamobile.org 
   127.0.0.1     market.gaiamobile.org
   127.0.0.1     music.gaiamobile.org 
   127.0.0.1     settings.gaiamobile.org
   127.0.0.1     clock.gaiamobile.org
   127.0.0.1     crystalskull.gaiamobile.org
   127.0.0.1     penguinpop.gaiamobile.org
   127.0.0.1     towerjelly.gaiamobile.org
   127.0.0.1     wikipedia.gaiamobile.org
   127.0.0.1     cnn.gaiamobile.org 
   127.0.0.1     bbc.gaiamobile.org 
   127.0.0.1     nytimes.gaiamobile.org 
   127.0.0.1     calculator.gaiamobile.org
   127.0.0.1     system.gaiamobile.org

後面的 gaiamobile.org 則依前面設定的 ``GAIA_DOMAIN`` 而定

之後移動到 B2G 的執行檔位置，他會在所設定的 ``MOZ_OBJDIR`` 底下的 ``dist/bin/`` 內

::

    $ cd MOZ_OBJDIR/dist/bin

不要移動過去也是可以，我們要執行的就是底下的 ``b2g`` 這隻程式

執行時幫他加上 gaia profile 資料夾的位置（profile 會在 gaia make 的時候產生）

::

    $ ./b2g -profile GAIA/profile

上面兩個步驟的 ``MOZ_OBJDIR`` 和 ``GAIA`` 請自行更換成對應的路徑，

如果沒有意外的話就會看到 B2G 的 screen lock 了

.. image:: https://github.com/a13524000/float-blog/raw/master/img/b2g_desktop_screenshot.jpeg

``-profile`` 的部份我的了解是他會利用後面的 profile 在本機上執行 service，

所以在 netstat 可以看到幾個由 b2g listen 的 port

::

    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 127.0.0.1:2828          0.0.0.0:*               LISTEN      13371/b2g       
    tcp        0      0 127.0.0.1:5037          0.0.0.0:*               LISTEN      4702/adb        
    tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      13371/b2g       
    tcp        0      0 127.0.0.1:4242          0.0.0.0:*               LISTEN      13371/b2g 

這時除了在 b2g 本身的界面運行外，也可以試著用其他瀏覽器去連看看，

網址會是 appname.gaiamobile.org:8080 不過基本上要用 Firefox 15 以上才會有比較正常的效果。

如果想要自己丟一個 app 進去試試看的話，現在的 gaia/apps 底下有一個 template 的資料夾，

就是一個空的 app 可以參考他，以及其他其他底下的 app 來寫 ``manifest.webapp`` 這個檔案，

app 部份就主要是 HTML 和 javascript ，寫好後放在 gaia/apps 底下後重新 make 即可。

至於 app 的詳細寫法因為不是本篇重點便不詳述。

在參考資料的 gaia hacking 中也有其他多種除了在手機上執行 b2g 以外的方式，

另外如果執行上碰到什麼問題可能是我寫錯的地方也請留言指教，謝謝。

參考資料
--------

gaia hacking

https://wiki.mozilla.org/Gaia/Hacking

build firefox

https://developer.mozilla.org/En/Simple_Firefox_build

using gaia in firefox

https://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/Using_Gaia_in_Firefox

Setup Gaia on Mac With Firefox Nightly Build

http://alivedise.github.com/blog/2012/05/05/gaia/
