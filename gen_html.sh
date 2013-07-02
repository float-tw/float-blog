#!/bin/bash

if [ $# != 1 ]; then
	echo 'no input file or too many';
fi

rst2html.py --stylesheet=style.css --syntax-highlight=short $1 > $(echo $1 | cut -d '.' -f 1).html
#rst2html.py --stylesheet=style.css --syntax-highlight=short test.rst > test.html
#rst2html.py --link-stylesheet $1 > $(echo $1 | cut -d '.' -f 1).html
