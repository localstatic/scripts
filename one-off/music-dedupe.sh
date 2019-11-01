#!/bin/bash

# This is not a generally safe script. It is highly dependent on the names of the duplicate files
# The initial version only worked when " 2" was appended to the base filename. Future use of this 
# script will almost certainly require changes to the duplicate detection pattern/logic
exit

#for dir in `find . -iname \*\ 2.mp3 | sed -E 's|/[^/]+$||' | sort -r | uniq`; do
	#cd "$dir"

	for file in *\ 2.mp3; do
		orig=`echo $file | sed 's/ 2\.mp3$/.mp3/'`

		echo -n "$file ... "
		if [[ -f $orig ]]; then
			echo -n "matching file found at \"${orig}\" ... "

			rm -f "$file"

			echo "deleted duplicate (\"${file}\")."
		else
			echo "match not found."
		fi

		echo
	done

	#cd -
#done


