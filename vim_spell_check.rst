[Vim] 拼字檢查
==============

這是一個 Vim 7 新增的功能，可以作拼字檢查。

另外在某些文件中（例如 c file），只會針對是文字的部份作檢查，

例如 ``ch = "appll"`` 會被認為是拼字錯誤，而 ``appll = 10`` 則不會。


使用
----

開啟拼字檢查 ``set spell``

關閉拼字檢查 ``set nospell``

並且可以使用 ``set spelllang=en_GB`` 來設定檢查的語言

跳躍
----

啟動拼字檢查後可以使用 ``[s`` ``]s`` 來前往前後尋找拼字錯誤的地方。

修正
----

游標在錯字上按下 ``z=`` 會進入選擇頁面，利用數字選擇正確的拼字。

補齊
----

在啟動拼字檢查的狀態下，利用 ``^x s`` 便可以作拼字的補齊。

其他
----

``zg`` 新增自訂正確拼字， ``zug`` 刪除

``zw`` 刪除自訂錯誤拼字， ``zuw`` 刪除

另外，在參考了 `Tsung's Blog <http://blog.longwin.com.tw/2006/06/vim7_function_2006/>`_ 後

我也把 F2 設定成了切換檢查的開關，以及修改錯字標記的樣式 ::

    hi clear SpellBad
    hi SpellBad term=underline cterm=underline ctermfg=red
    map <F2> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>


參考資料
--------

http://blog.longwin.com.tw/2006/06/vim7_function_2006/

http://yyq123.blogspot.tw/2010/09/vim-spell-check.html

http://pre.tir.tw/008/blog/output/vim-7-spell-check.html
