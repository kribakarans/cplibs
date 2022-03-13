#!/bin/bash

set -e

VERSION=1.2

DEST=$PWD
DESC='Extract the shared-object dependencies of an executable'

usage() {
cat << USAGE
Usage: $(basename $0) [OPTION] [FILE] ...
$DESC
Options:
    -d  --directory <target-directory>
                   -- Copy extracted file to the target-directory
    -v  --version  -- Print pckage version
    -h  --help     -- Show this message
USAGE

	exit 1
}

#main()
#Validate cmdline inputs
if [ $# -lt 1 ]; then
	cat << CLIERROR
$(basename $0): missing file operand
Try 'cplibs --help' for more information.
CLIERROR

	exit 1
fi

SHORTOPTS=d:hv
LONGOPTS=directory:,help,version

GETOPTS=$(getopt -o $SHORTOPTS --long $LONGOPTS -- "$@")
[[ "$?" != "0" ]] && usage

eval set -- "$GETOPTS"
while :
do
	case "$1" in
		-d | --directory)
			DEST=$2; shift 3; break
		;;
		-h | --help)
			usage;
		;;
		-v | --version)
			echo "$(basename $0): Version: $VERSION - $DESC"
			exit 0;
		;;
		--) shift; break ;;
		*) echo "Unexpected option: $1"
	esac
done


#Create target directory if set
if [ "$DEST" != "$PWD" ]; then
	mkdir -p $DEST
fi

for FILE in "$@"
do
	[[ ! -e $FILE ]] && echo "$FILE: file not found !!!" && continue;

	printf "Copying dependencies of '$FILE' "
	[[ "$DEST" != "$PWD" ]] && echo "to $DEST" || echo ""

	#Get shared object dependencies
	DEPS=$(ldd $FILE | awk 'BEGIN{ORS=" "}$1 ~/^\//{print $1}$3~/^\//{print $3}' | sed 's/,$/\n/')

	#Copy the dependencies
	for DEP in $DEPS
	do
		TARGET=$DEST$DEP
		echo "    $DEP"
		if [ ! -e $TARGET ]; then
			install $(stat -L -c '-m %a' "$DEP") -D $DEP $TARGET
		fi
	done
done

exit 0

