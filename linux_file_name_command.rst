[Linux] 檔名相關指令
====================

取得檔案（相對路徑）的絕對路徑::

    readlink -f dir/to/file

    ex

    float@dorm:~/float-blog$ readlink -f ~/float-blog/linux_file_name_command.rst 
    /home/float/float-blog/linux_file_name_command.rst

取得檔案所在目錄::

    dirnam dir/to/file

    ex

    float@dorm:~/float-blog$ dirname ~/float-blog/linux_file_name_command.rst 
    /home/float/float-blog

取得檔案名稱::

    basename dir/to/file

    ex

    float@dorm:~/float-blog$ basename ~/float-blog/linux_file_name_command.rst 
    linux_file_name_command.rst
