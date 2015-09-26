#!/bin/bash

failed() {
    echo $1 >&2
    exit $2
}

test -z "${1}" && failed "give uid parameter" -1
test -z "${2}" && failed "give user name" -1

cat /etc/passwd | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | grep "^${1}:${2}" && exit
# else
USER=$( cat /etc/passwd | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | grep "^${1}:" | cut -f2 -d':' )
test -z "${USER}" && exit

i=$((${1} + 1))
while test $i -lt 65534 ; do
    LINE=$( cat /etc/passwd | sed -e 's#\([^:]*\):[^:]*:\([^:]*\).*#\2:\1#' | sort -n | grep "^${i}:" )
    test -z "${LINE}" && usermod -u ${i} ${USER} && exit
    i=$(($i + 1))
done
