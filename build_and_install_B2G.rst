Build and Install B2G
=====================

環境
----

括號為官方建議

- Ubuntu 12.04 LTS x86_64 ( 11.10 x86_64 )

- 2GB RAM ( 4GB )

- 10GB swap space ( at least 4GB )

- at least 80GB hard disk space

- Samsung Nexus S GT-I9023 with ICS-kernel ( Samsung Nexus S[I9020,I9023], S2[I9100] )

需要的 tools

::

	$ sudo apt-get install ia32-libs gcc-multilib g++-multilib bison \
	flex gperf lib32z1-dev lib32ncurses5-dev lib32ncursesw5-dev \
	libidl-dev lib32gomp1 autoconf2.13 ccache libx11-dev \
	lib32readline-gplv2-dev lib32tinfo-dev

先安裝 java jdk 方便後面的步驟

::

	$ sudo apt-get install openjdk-6-jdk

安裝 Android SDK

先到 `Android SDK starter package`_ 下載

解壓縮後執行 ``$ ./android-sdk-linux/tools/android``

然後僅勾選頁面中的 Android SDK tools, Android SDK platform-tools 後，點選右下角的 Install 2 packges...（數字是由勾選的數目決定）

完成安裝後在 ``~/.bashrc`` 中更新 PATH 方便使用

::

	# in ~/.bashrc
	# 依照 Android SDK 放置的路徑調整
	PATH=$PATH:/path_to_android-sdk-linux/platform-tools
	export PATH

.. _Android SDK starter package: http://developer.android.com/sdk/index.html

將手機的 USB debugging 打開，應該在 **應用程式->開發->USB 偵錯**

接著設定 ``/etc/udev/rules.d/51-android.rules``

::

	#in /etc/udev/rules.d/51-android.rules
	SUBSYSTEM=="usb", ATTRS{idVendor}=="04e8", MODE="0666"
	SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", MODE="0666"

編譯
----

這部份和之後的刷機官方的說明有修改過，用幾個 script 通包了，還像蠻懶人包的，

原本是用 Makefile 那我還是依照當初用 Makefile 的作法介紹（這部份也沒有很複雜），

script 的部份可以參考官方文件

`Preparing_for_your_first_B2G_build`_

`Building_Boot_to_Gecko`_

.. _Preparing_for_your_first_B2G_build: https://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/Preparing_for_your_first_B2G_build

.. _Building_Boot_to_Gecko: https://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/Building_Boot_to_Gecko

首先從 github 下載 B2G 專案

::

	git clone https://github.com/andreasgal/B2G.git

在這邊 git 我有遇到一個問題，當從 https clone 的時候會有錯誤

error: gnutls_handshake() failed: A TLS packet with unexpected length was received

改成 http 可以暫時解決這個問題，不過後續還很多 https 的部份，

我查到的解決辦法是把 git 抓回來自己重新編譯。

接下來 Makefile 的部份也可以參考 B2G 專案下的 INSTALL

首先把完整的專案下載

::

	$ cd B2G
	$ make sync

接著 config ，不同手機要用不同的，這邊以 Nexus S 做範例

::

	$ make config-nexuss-ics

由於 gonk-ics 並沒有包含在前面 sync 完專案中所以這個步驟還會去作 ``make gonk-ics-sync``

上面兩個部份都非常花時間，一兩個小時以上跑不掉，在加上 sync 錯誤的話要重作幾次，

建議在網路狀況好一點的時後做，或是睡前（不過就怕起來看到錯誤...）

完成以後就可以開始編譯 gonk

::

	$ make gonk

這步驟也是有點久的，完成後編譯其他部份

::

	$ make


刷機
----

首先把手機解鎖， Makefile 裡面連這個也有，夠懶吧

::

	$ make unlock-bootloader
	或是想要自己來
	$ fastboot oem unlock

這邊要提一下，幾乎全部寫在 Makefile 中的動作都是當作手機是開機的狀態，

所以如果需要進 bootloader 他會先 ``adb reboot bootloader`` ，

如果手機已經在 bootloader 下的話會錯誤，就先把手機正常開機吧。

然後就可以開始刷機了，嗯這個也都寫好好了

::

	$ make flash-only

這邊完成後手機就會重新開機到 B2G 底下了，不過看到的應該是 Server not found 的畫面，

因為 gaia 還沒安裝，所以接著安裝 gaia

::

	$ make install-gaia

這個步驟會去把 gaia 裡的 home, apps 做快取然後手機上，所以如果不想在上面看到一堆程式，

可以在 ``B2G/gaia/apps`` 底下刪掉，想放進自己寫也可以丟進去。

這樣就完成了。

因為有些部份是照印象寫的，如果有漏掉或錯誤的部份煩請告訴我一下，謝謝。

參考資料
--------

官方文件

https://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/Building_and_installing_Boot_to_Gecko

自己編譯 Boot2Gecko 快速上手

http://littleqnote.blogspot.tw/2012/05/boot2gecko.html

謀智台客

http://tech.mozilla.com.tw/posts/127/b2g-on-emulator-2
