#!/bin/bash

for file in *\ 2.mp3; do
	orig=`echo $file | sed 's/ 2\.mp3$/.mp3/'`

	#echo $file
	#echo $orig
	#file2=`echo $file | sed 's/ /\\\\ /g'`

	echo -n "$file ... "
	if [[ -f $orig ]]; then
		echo "matching file found at \"${orig}\" ... "

		rm -f "$file"
	else
		echo "match not found."
	fi

	echo
done
