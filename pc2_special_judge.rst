[PC\ :sup:`2`\ ] special judge
==============================

剛辦完 ACmarathon 剛好研究了 pc\ :sup:`2` 的 special judge 怎麼設定

所使用的 pc\ :sup:`2` 版本是 9.2.3 系統是 Ubuntu 12.04 LTS 

首先需要設定的是題目所使用的 Validator 也就是 judge 的程式

通常如果不用 special judge 的話可以使用 pc\: sup:`2` 的 Validator

那 special judge 的話就選用 External Validator

.. image:: https://github.com/a13524000/float-blog/raw/master/img/pc2_validator_setting.jpeg

然後按 Validator Prog... 後面選擇 judge 的程式，可以是現成的某個程式 (diff...)

也可以自己寫，第二個部份就是 Validator Command Line

這邊是設定如何去執行這個 Validator 這邊有提供五個變數可以使用

{:validator}    judge 程式的名稱，也就是前面選擇的程式（不包含路徑）

{:infile}       input file，input 測資的檔名

{:outfile}      outpu file，參賽者程式接受 input 後的 output

{:ansfile}      從 pc\ :sup:`2` 設定的答案檔名

{:resfile}      必須輸出的 judge 結果（是個 xml file）

先舉個例子，如果你所選擇的 judge 程式叫做 sp 然後你的 Validator Command Line 這樣寫::

    ./{:validator} {:infile} {:outfile} {:ansfile} {:resfile}

那執行 judge 的時候就會這樣執行::

    ./sp input outpu ans result

當然如果你的 judge 程式是用 java, python 寫的也可以這樣寫::

    java {:validator} {:infile} {:outfile} {:ansfile} {:resfile}

    python {:validator} {:infile} {:outfile} {:ansfile} {:resfile}

當然這些參數的順序是可以任意變動的，如果不需要某些檔案也可以不寫

執行時檔案都會被放在同一個目錄下，像是 ``pc2-9.2.3/bin/executesite1judge1``

當你的 judge 程式執行完後必須依照所給定的 resfile 檔名產生一個檔案

這個檔案的內容大概是這樣::

    <?xml version="1.0"?>
    <result outcome =  "No - Wrong Answer" security = "132XRSAM.txt">Answer and output file different at line  1</result>

這是一個 WA 的範例，首先第一行就是 xml 的 tag

接著第二行是一個 result tag 裡面包含 outcome 和 security

outcome 就是 judge 的結果，pc\ :sup:`2` 會去比對在 Judgements 裡面所設定的結果來回應給 client

預設包含這幾種結果::

    Yes
    No - Compilation Error
    No - Run-time Error
    No - Time-limit Exceeded
    No - Wrong Answer
    No - Excessive Output
    No - Output Format Error
    No - Other - Contact Staff
    
如果 result file 沒有被正確產生，或是比對不到一樣的結果則會回應 "Undetermined"

security 則是 resfile 的檔案名稱（猜測應該是為了防止上傳可以產生 result file 的程式用的）

tag 裡面的字串並不會被 pc\ :sup:`2` 拿來使用，可以是一些錯誤的原因之類的

而如果 AC 的話 outcome 的文字可以使用 "Yes" 或 "accepted" 下面是一個 AC 的範例::

    <?xml version="1.0"?>
    <result outcome =  "accepted" security = "561XRSAM.txt"></result>

另外如果檔案有被產生，而 xml 格式有錯誤（像是少了 security）則狀態會留在 NEW 而 client 也不會收到結果

如果有這樣的問題可以檢查一下（這個問題弄了超久 Orz）

