#!/bin/sh

set -ex

function usage {
    echo "./run.sh <component> <workspace> [plan|apply|plan-apply|destroy|taint|cmd]"

    exit 1
}

function plan {
    planfile=$1
    varsfile=$2
    shift 2

    terraform plan "$@" -var-file=$varsfile -out $planfile
}

function apply {
    planfile=$1
    shift 1

    terraform apply "$@" $planfile
}

if [ -z $1 -o -z $2 -o -z $3 ]; then
    echo "./run.sh <component> <workspace> <action>"
    exit 1
else
    component=$1
    workspace=$2
    action=$3
    plan=/tmp/$component-$workspace
    vars=$(pwd)/environments/$workspace/$component.tfvars
    shift 3

    pushd components/$component
    terraform workspace select $workspace
    terraform get

    case $action in
        plan)
            plan $plan $vars "$@"
            ;;
        apply)
            apply $plan "$@"
            ;;
        plan-apply)
            plan $plan $vars "$@"
            apply $plan "$@"
            ;;
        destroy)
            terraform destroy "$@"
            ;;
        taint)
            state=terraform.tfstate.d/${workspace}/terraform.tfstate
            terraform taint -state=$state "$@"
            ;;
        cmd)
            terraform "$@"
            ;;
        *)
            usage
            ;;
    esac

    popd
fi
