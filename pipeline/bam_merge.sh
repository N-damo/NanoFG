#!/bin/bash

usage() {
echo "
Required parameters:

Optional parameters:
    -d|--split_directory
    -s|--sambamba_path
    -o|--output
    -h|--help       Shows help
"
}

POSITIONAL=()
SAMBAMBA='/hpc/local/CentOS7/cog_bioinf/sambamba_v0.6.5/sambamba'
OUTPUT='/dev/stdout'
SPLITDIR=./split_vcf

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
    -h|--help)
    usage
    exit
    shift # past argument
    ;;
    -d|--split_directory)
    SPLITDIR="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--sambamba_path)
    SAMBAMBA="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    OUTPUT="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo `date`: Running on `uname -n`

$SAMBAMBA merge $OUTPUT $SPLITDIR/*/*last.sorted.bam

echo `date`: Done