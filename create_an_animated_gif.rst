製作 gif 動畫
=============

因為看到了一些 vim plugin 利用 gif 動畫來 Demo plugin 的效果，

最近也自己在寫 vim plugin 所以也想來做看看，

製作過程分成三個步驟

錄製影片
--------

首先我利用 kazam 來錄製影片，選用 kazam 的原因是因為他可以利用拖拉的方式來選取

錄製範圍，雖然在一些小地方的中文顯示有點問題，不過不影響使用。

將影片轉成 gif 檔
-----------------

接下來使用 mplayer 把影片轉換成 gif 檔。

.. code-block::

    mplayer input.mp4 -ao null -vo gif89a:fps=13 output=output.gif

另外可以加上 ``-ss`` 和 ``-endpos`` 來設定轉換的時間起點和長度，

這部份可以參考後面附的參考資料。

壓縮 gif 檔
-----------

由於轉換出來的 gif 檔案會很大，以我自己錄製的檔案為例，

原本解析度 818x502 時間長度 37 秒總共大小才 662 KB 的 mp4 影片，

轉換成 gif 檔後竟然有 8.2 MB，這樣放在網頁上的載入時間怕會有點久，

所以利用 convert 幫他瘦身一下

.. code-block::

    convert output.gif -fuzz 10% -layers Optimize optimised.gif

剛剛提到的檔案瘦身之後剩下 666 KB。

我錄起來的結果是有些小地方不太清楚，不知道像 `YouCompleteMe`_ 的是怎麼錄的，

感覺就蠻清晰的 Orz，我自己錄的在這 `easyreST`_

.. _YouCompleteMe : https://github.com/Valloric/YouCompleteMe

.. _easyreST : https://github.com/float-tw/easyreST/

參考資料
--------

http://www.tux-crazy.com/2012/04/how-to-create-animated-gif-from-video.html

http://unix.stackexchange.com/questions/35282/convert-ogv-video-to-gif-animation
