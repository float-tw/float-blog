大量取代檔案中關鍵字
====================

逛 `github <http://github.com>`_ 的時候突然發現可以改 username，

之前被 jserv 嫌帳號太難記就索性換掉，

換完才想到 blog 的圖都放在上面阿 Orz，

部落格上面的就複製下來取代掉，原始檔的部份當然就交給指令來取代::

   grep a13524000 * | cut -d ':' -f 1 | uniq | xargs sed -i 's/a13524000/float-tw/g'

先用 `grep` 找到有關鍵字的檔案，再用 `cut` 切出檔名，用 `uniq` 去除重複的，

最後用 `xargs` 餵給 `sed` 做取代
