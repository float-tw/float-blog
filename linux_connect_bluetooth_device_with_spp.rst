[Linux] 與藍牙裝置建立 spp 連線
===============================

首先將電腦與藍牙裝置進行配對

接著使用以下指令之一取得電腦之 BD Address::

    $ hciconfig -a
    or
    $ hciconfig dev
    or
    $ hcitool dev

    例：
    ┌[float@float-X220]:~
    └─$ hcitool dev
    Devices:
            hci0    40:2C:F4:E3:14:31


以我自己為例就是 40:2C:F4:E3:14:31

然後取得藍牙裝置的 BD Address::

    $ hcitool scan

    例：
    ┌[float@float-X220]:~
    └─$ hcitool scan
    Scanning ...
            98:E7:9A:08:52:96   float-XT535

這邊是 98:E7:9A:08:52:96

再來建立虛擬序列埠裝置::

    $ sudo mknod /dev/rfcomm0 c 216 1
    $ sudo chmod 666 /dev/rfcomm0

修改 ``/etc/bluetooth/rfcomm.conf`` 為其建立設定::

    $ sudo vim /etc/bluetooth/rfcomm.conf 

    rfcomm0{
        bind no;                    //設置是否自動綁定設備
        device 40:2C:F4:E3:14:31;   //設定綁定設備的BD Address(電腦)
        channel 1;                  //設定設備通道
        comment "BTM";              //對設備的描述
    }

添加 SPP(Serial Port Profile) 的SDP協議通道::

    $ sudo sdptool add --channel=1 SP

將虛擬序列埠與藍牙裝置綁定::

    $ sudo rfcomm bind /dev/rfcomm0 98:E7:9A:08:52:96 1

連接::

    $ sudo hcitool cc 98:E7:9A:08:52:96

接著就可以使用可以連接序列埠的程式進行連線，像是 picocom 或 minicom

這邊推薦 picocom 因為我覺得比起 minicom 他的操作簡單許多::

    $ picocom /dev/rfcomm0

離開方式為 ``^a ^x  (ctrl+a ctrl+x)``

參考資料
========

http://stll516.blogspot.tw/2010/01/linuxbluetoothsppserial-port-profile.html
