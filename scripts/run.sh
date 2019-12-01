#!/bin/sh

set -e

if [ -z $1 -o -z $2 ]; then
    echo "./run.sh <component> <workspace>"
    exit 1
else
    pushd components/$1
    terraform workspace select $2
    shift 2
    terraform get
    terraform "$@"
    popd
fi
