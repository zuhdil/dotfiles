#!/usr/bin/env bash

SCRIPT=$(basename "$0")
SOURCEDIR=$(pwd)
[ -z "$1" ] && TARGETDIR="$HOME" || TARGETDIR="${1%\/}"

for directory in $(find . ! -path . ! -path "*\/.*" -type d | sed 's/^\.\///'); do
    destination="$TARGETDIR/.$directory"

    if [ -d $destination -o -L $destination ]; then
        #echo "skip creating directory, '$destination' already exists"
        continue
    fi

    mkdir -p $destination
    #echo "directory '$destination' created"
done

for filerc in $(find . ! -path "*\/.*" ! -name "$SCRIPT" ! -iname "*readme*" -type f | sed 's/^\.\///'); do
    destination="$TARGETDIR/.$filerc"
    source="$SOURCEDIR/$filerc"

    if [ -L $destination -a "$(readlink -f $destination)" -ef $source ]; then
        #echo "$destination is already symlinked"
        continue
    fi

    if [ -f $destination -a ! -L $destination ]; then
        echo "found existing file $destination, creating backup in $destination.orig"
        cp $destination $destination.orig
        rm $destination
    fi

    if [ -L $destination ]; then
        #echo "replace already exist symlink $destination"
        rm $destination
    fi

    #echo "linked $source -> $destination"
    ln -s $source $destination
done
