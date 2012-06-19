Build Android-ICS Kernel for Nexus S
====================================

環境
----

- Ubuntu 12.04 LTS x86_64

- GNU make 3.8.1

- Git 1.7.11.rc2

編譯環境需求可以參考 http://source.android.com/source/initializing.html

ps. 有部份完整編譯 android 所需要的。

下載source
----------

首先要先找到想要編譯 kernel 的 git log 這邊必須下載 drvice project

而 project 命名方式是 device/<vendor>/<name>

而 Nexus S 是 samsung 出的然後名字叫 crespo

::

	$ git clone https://android.googlesource.com/device/samsung/crespo
	$ cd crespo
	$ git log kernel

之後可以在 git log 裡面找所需要的 commit

接下來下載 kernel source

::

	$ git clone https://android.googlesource.com/kernel/samsung.git

下載、設定 toolchain

::

	$ git clone https://android.googlesource.com/platform/prebuilt
	$ export PATH=$(pwd)/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH

編譯
----

::

	$ export ARCH=arm
	$ export SUBARCH=arm
	$ export CROSS_COMPILE=arm-eabi-
	$ cd samsung
	$ git checkout <commit_from_first_step>
	$ make herring_defconfig
	$ make menuconfig
	$ make -j$(($(grep -c processor /proc/cpuinfo) * 3 / 2))

``make herring_defconfig``\ 使用預設的設定

``make menuconfig``\ 再去做所需要的調整（像我是想開啟 Oprofile 的支援）

<commit_from_first_step>的部份就是在前面 git log 裡找到的 commit

make 加上 -j 加速一下編譯，

完成後就可以在 ``samsung/arch/arm/boot`` 底下找到 zImage 了

至於解開 boot.img 更換 zImage 在重新打包的步驟可以在參考資料的後兩篇找到。

燒錄所需要的 adb, fastboot 可以下載 `android sdk`_

.. _android sdk: http://developer.android.com/sdk/index.html

參考資料
--------

環境設定

http://source.android.com/source/initializing.html

編譯流程

http://source.android.com/source/building-kernels.html

不同 device project 的位置可以參考

http://renren.it/a/caozuoxitong/Windows/20120607/168711.html

下面兩篇是 2.6 的基本上大同小異

http://glandium.org/blog/?p=2214

http://my.oschina.net/lcx2007/blog/37870
