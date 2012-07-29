[Linux] 關閉螢幕
----------------

通常筆電上都有個 Fn + F? 可以把螢幕關掉省省電之類的，

可是現在在用的 x220 沒有阿，在 windows 好像可以用 thinkpad 的軟體把

Fn + F3 設定程關閉螢幕，只是在 Ubuntu 下他就只能跳出電源統計 Orz。

目前找到了兩個方法：

一個是 ``xset`` 另一個是 ``vbetool``

::

    xset dpms force off

螢幕會關閉，而且鍵盤、滑鼠移動的時候就會喚醒螢幕。

所以剛好拿來給快速鍵用，我把他綁到 ThinkVantage 上。

::

    sudo vbetool dpms on
    sudo vbetool dpms off

這個需要權限而且不會自動喚醒，不過還是題一下。
