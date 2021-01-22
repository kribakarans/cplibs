#!/bin/bash 

function usage()
{
    cat << EOU
$(basename $0): missing file operand
Usage: $(basename $0) <executable>
Copy shared libraries of an executable to the 'libs' directory.
EOU
exit 1
}

path="libs.1"

mkdir -p $path

#Validate the inputs
[[ $# < 1 ]] && usage

#Check if the paths are vaild
[[ ! -e $1 ]] && echo "Not a vaild input $1" && exit 1 
[[ -d $path ]] || echo "No such directory $path creating..."&& mkdir -p "$path"

#Get the library dependencies
echo "Collecting the shared library dependencies for $1..."
deps=$(ldd $1 | awk 'BEGIN{ORS=" "}$1\
~/^\//{print $1}$3~/^\//{print $3}'\
 | sed 's/,$/\n/')
echo "Copying the dependencies to $path"

#Copy the deps
for dep in $deps
do
    echo "Copying $dep to $path"
    cp "$dep" "$path"
done

