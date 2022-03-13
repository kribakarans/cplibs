#!/bin/bash

set -e

VERSION=1.1
DEST=./cplibs.d

usage() {
cat << EOU
$(basename $0)-$VERSION: missing file operand
Usage: $(basename $0) [FILE] ...
Copy shared object dependencies of an executable to the directory '$DEST'.
EOU
    exit 1
}

#Validate the inputs
[[ $# < 1 ]] && usage

#Create target directory if not exist
[[ ! -d $DEST ]] && mkdir -p "$DEST"

for FILE in "$@"
do
	[[ ! -e $FILE ]] && echo "$FILE: file not found !!!" && continue;

	#Get the library dependencies
	echo "Copy dependencies of '$FILE' to $DEST"

	#Get shared object dependencies
	DEPS=$(ldd $FILE | awk 'BEGIN{ORS=" "}$1 ~/^\//{print $1}$3~/^\//{print $3}' | sed 's/,$/\n/')

	#Copy the dependencies
	for DEP in $DEPS
	do
		echo "copying ... $DEP"
		install $(stat -L -c '-m %a -g %g -o %u' "$DEP") -D $DEP $DEST$DEP
	done
done

exit 0
