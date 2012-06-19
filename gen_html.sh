#!/bin/bash

if [ $# != 1 ]; then
	echo 'no input file or too many';
fi

rst2html --link-stylesheet $1 > $(echo $1 | cut -d '.' -f 1).html
