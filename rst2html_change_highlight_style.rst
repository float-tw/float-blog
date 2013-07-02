[reST] 修改 rst2html highlight sytle
====================================

不知道為什麼上一篇裝完新的 rst2html 轉出來的 syntax highlight 超醜，明明 restview 弄出來得很漂亮阿....

rst2html 不加參數

.. image:: https://github.com/float-tw/float-blog/raw/master/img/rst2html.jpeg

restview

.. image:: https://github.com/float-tw/float-blog/raw/master/img/restview.jpeg

查了一下可以從 pygmentize 匯出 syntax highlight 的 css (\ 來源_\ )::

    $ pygmentize -S default -f html -a .highlight > style.css

.. _來源: http://stackoverflow.com/questions/9807604/how-can-i-get-rst2html-py-to-include-the-css-for-syntax-highlighting

匯出以後會得到一個像這樣的檔案::

    .highlight .hll { background-color: #ffffcc }
    .highlight  { background: #f8f8f8; }
    .highlight .c { color: #408080; font-style: italic } /* Comment */
    .highlight .err { border: 1px solid #FF0000 } /* Error */
    .highlight .k { color: #008000; font-weight: bold } /* Keyword */
    .highlight .o { color: #666666 } /* Operator */
    .highlight .cm { color: #408080; font-style: italic } /* Comment.Multiline */
    .highlight .cp { color: #BC7A00 } /* Comment.Preproc */

接下來看一下把這段 code 原本用 rst2html 轉換後的結果

.. _這裡:

.. code-block:: c

    int main()
    {
        int x;
        printf("hello\n");
        return 0;
    }
    
::

    $ rst2html test.rst > test.html

.. code-block:: html

    <pre class="code c literal-block">
    <span class="keyword type">int</span> <span class="name function">main</span><span class="punctuation">()</span>
    <span class="punctuation">{</span>
        <span class="keyword type">int</span> <span class="name">x</span><span class="punctuation">;</span>
        <span class="name">printf</span><span class="punctuation">(</span><span class="literal string">&quot;hello</span><span class="literal string escape">\n</span><span class="literal string">&quot;</span><span class="punctuation">);</span>
        <span class="keyword">return</span> <span class="literal number integer">0</span><span class="punctuation">;</span>
    <span class="punctuation">}</span>
    </pre>

接下來需要修改一下 rst2html 的參數和剛剛的 sytle.css 讓 css 可以正確生效

首先是 <pre> 的 class 部份 code-block 轉換出來的是 code 而 sytle.css 裡面用的是 highlight 所以要先把 highlight 都改成 code::

    .code .hll { background-color: #ffffcc }
    .code  { background: #f8f8f8; }
    .code .c { color: #408080; font-style: italic } /* Comment */
    .code .err { border: 1px solid #FF0000 } /* Error */
    .code .k { color: #008000; font-weight: bold } /* Keyword */
    .code .o { color: #666666 } /* Operator */
    .code .cm { color: #408080; font-style: italic } /* Comment.Multiline */
    .code .cp { color: #BC7A00 } /* Comment.Preproc */

接著是不同部份所使用 highlight 的 class 原本轉出來的結果是使用較長的敘述，

這部份需要在 rst2html 加上 ``--syntax-highlight=short``

使他使用簡短敘述，完成後同時指定 ``--stylesheet=style.css`` 使用剛剛的 css::

    $ rst2html.py --stylesheet=style.css --syntax-highlight=short test.rst > test.html

轉換完的 html

.. code-block:: html

    <pre class="code c literal-block">
    <span class="kt">int</span> <span class="nf">main</span><span class="p">()</span>
    <span class="p">{</span>
        <span class="kt">int</span> <span class="n">x</span><span class="p">;</span>
        <span class="n">printf</span><span class="p">(</span><span class="s">&quot;hello</span><span class="se">\n</span><span class="s">&quot;</span><span class="p">);</span>
        <span class="k">return</span> <span class="mi">0</span><span class="p">;</span>
    <span class="p">}</span>

使用後的結果就如\ 這裡_\ 所示
