#!/bin/sh

set -e

if [ -z $1 -o -z $2 ]; then
    echo "./raw.sh <component> <args>..."
    exit 1
else
    pushd components/$1
    shift 1
    terraform $@
    popd
fi
