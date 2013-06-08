[Linux] 使用 convert 做圖片轉檔
===============================

convert 是 ImageMagick 的一個 CLI tool

所以安裝 ImageMagick 就可以得到他了！

可以用來做圖片轉檔，調整大小，也還有其他很強大的功能

這邊簡單介紹一下圖片轉檔和調整大小的方法

首先，圖片轉檔的部份非常簡單舉個例子，如果要把 png 檔轉成 jpeg 檔::

    convert input.png outpu.jpeg

好了，就這樣，要轉的檔名放前面，輸出檔名放後面，convert 會自己根據副檔名做轉換

簡單吧。

調整大小的話::

    convert input.png -resize 64x64 output.png

這樣就可以把圖片縮放到可以放入 64x64 的方形內，

那如果要把他轉成真的是 64x64 呢？加上驚嘆號強制調整，像這樣::

    convert input.png -resize 64x64\! output.png

倒斜線是有時候因為 shell 的關係可能驚嘆號是脫逸字元，有時不加也是可以的。

