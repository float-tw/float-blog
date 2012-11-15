停用 F10 選單鍵 (ubuntu 12.04)
==============================

之前在 mosut_ 聚會聽到了 mc 這個 cli 的檔案管理程式

.. _mosut: http://mosut.org

今天想說來是用看看好了， mc 裡面的離開是 F10，

由於 F10 在 gonme-terminal 預設是開啟選單，所以就依照之前 `這篇`_ 把 F10 disable 了，

.. _這篇: http://blog.float.tw/2012/10/disablef1ingnometerminal.html

在 mc 裡面就可以正常離開了，不過發生了一件事，竟然跳出了右鍵選單，

結果到處試了一下，F10 好像被設定成選單鍵了，原本在 stackoverflow 找到用 compizconfig-settings-manager

可以設定，不過似乎找不到對應的設定，後來有找到了下面的方式::

    mkdir -p ~/.config/gtk-3.0
    cat <<EOF > ~/.config/gtk-3.0/gtk.css

    @binding-set NoKeyboardNavigation {
         unbind "<shift>F10"
    }

    * {
         gtk-key-bindings: NoKeyboardNavigation
    }

    EOF

也就是先建立 ``~/.config/gtk-3.0/gtk.css`` 這個檔案，並且加入 unbind 的設定，

這樣就 OK 了，在 12.04 unity 下測試是正常的。

參考資料
========

http://fcns.eu/2012/07/09/ubuntu-disabling-f10-key-functionality-for-mc/
