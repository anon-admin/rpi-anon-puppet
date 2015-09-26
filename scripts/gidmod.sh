#!/bin/bash

failed() {
    echo $1 >&2
    exit $2
}

test -z "${1}" && failed "give gid parameter" -1
test -z "${2}" && failed "give group name" -1

cat /etc/group | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | grep "^${1}:${2}" && exit
# else
GROUP=$( cat /etc/group | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | grep "^${1}:" | cut -f2 -d':' )
test -z "${GROUP}" && exit

i=$((${1} + 1))
while test $i -lt 65534 ; do
    LINE=$( cat /etc/group | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | sort -n | grep "^${i}:" )
    test -z "${LINE}" && groupmod -g ${i} ${GROUP} && exit
    i=$(($i + 1))
done
