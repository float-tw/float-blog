[Pyhotn] 使用 PyInstaller 打包 python 程式
==========================================

PyInstaller 可以用來把 Python 程式打包起來，方便在其他機器上執行，

省去安裝 Python 以及所使用套件的時間（尤其在 windows 上）

安裝 PyInstaller
----------------

先到 `官網`_ 下載 PyInstaller 的壓縮檔，並且解壓縮，放置到適合的路徑即可。

.. _官網 : http://www.pyinstaller.org/

使用方式
--------

使用方式的部份大致分為兩部份介紹。

第一個比較簡單的使用方式是直接使用 PyInstaller 內的 ``pyinstaller.py``

例如現在寫好了一個 hello.py 接著使用 pyinstaller.py

.. code-block::

    $ python path_to_PyInstaller/pyinstaller.py [OPTION] xxx.py

    ex.

    $ python path_to_PyInstaller/pyinstaller.py --onefile hello.py

執行後 pyinstaller 會為你的程式產生一個 .spec 檔（類似 makefile 的東西）

並且依據內容產生執行檔(pyinstaller 會提示你執行檔的位置)。

OPTION 的部份可以 ``$ python pyinstaller.py --help`` 查看，底下也列出一些供參考

::

    --onefile           製作出獨立的執行檔
    --onedir            製作出的檔案街放在同一個目錄下（預設值）
    --tk                製作包含TCL/TK的檔案。
    --windowed          製作視窗程式。（程式執行時不會有文字視窗出現）
    --console           製作一般的console程式。
    --upx               製作透過UPX壓縮過的執行檔。
    --icon=<FILE.ICO>   指定程式的圖示。
    --version=<FILE>    指定程式的版本資訊(需要準備一個檔案放這些資訊)。
    --name=<NAME>       指定程式的名稱。若無此選項，則主script檔案的名稱將被使用。

另外有時可能 pyinstaller 沒有辦法正確分析程式相依性，或者有特別需求時可能需要

先修改 .spec 檔在打包，又或者要使用現有的 .spec 檔打包時可以參考下列作法。

首先先使用 ``utils/Makespec.py`` 產生 .spec 檔

.. code-block::

    $ python path_to_PyInstaller/utils/Makespec.py [OPTION] xxx.py

    ex.

    $ python path_to_PyInstaller/utils/Makespec.py [OPTION] hello.py

接著便會產生與主程式同名的 hello.spec 便可以對他先做需要的修改， .spec 的內容大致如下

.. code-block::

    # -*- mode: python -*-
    a = Analysis(['hello.py'],
                 pathex=['/tmp'],
                 hiddenimports=[],
                 hookspath=None)
    pyz = PYZ(a.pure)
    exe = EXE(pyz,
              a.scripts,
              a.binaries,
              a.zipfiles,
              a.datas,
              name=os.path.join('dist', 'hello'),
              debug=False,
              strip=None,
              upx=True,
              console=True )


以筆者為例曾經在打包一個以 WxPython 撰寫的程式，打包完後執行會有以下的錯誤

.. code-block::

    ImportError: No module named scipy.sparse.csgraph._validation

那網路上查到比較多的作法都是在主程式裡加上一些 import 好讓 

pyinstaller 可以正確的分析出這個相依性這個相依性，不過這個作法讓我不太舒服，

因為一些檢查語法的 plugin 一樣找不到這個相依性，就會提醒我 import 了一個沒用到的東西，

所以我決定把他寫進 .spec 中，在 .spec 裡有個 Analysis 的項目其中有個 hiddenimports，

以筆者的例子就需要把 scipy.sparse.csgraph._validation 這個 module 加進去，像是這樣

.. code-block::

    # -*- mode: python -*-
    a = Analysis(['hello.py'],
                 pathex=['/tmp'],
                 hiddenimports=['scipy.sparse.csgraph._validation'],
                 hookspath=None)

    ..... 後略

這樣 pyinstaller 就會把這個 module 一同打包起來，就可以解決這個問題了。

編寫好 .spec 後就可以使用 ``utils/Build.py`` 來打包

.. code-block::

    $ python path_to_PyInstaller/utils/Build.py xxx.spec

    ex.

    $ python path_to_PyInstaller/utils/Build.py hello.spec

執行結果基本上和第一部份的相同。

參考資料
--------

http://www.dev.idv.tw/mediawiki/index.php/PyInstaller%E4%BD%BF%E7%94%A8%E7%B0%A1%E4%BB%8B
