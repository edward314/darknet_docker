#!/bin/sh

inputdir=
datasetdir=
outputdir=
image=edward314/darknet:latest

die() {
    echo "$@" 2>&1
    exit 1
}

while [ $# -gt 0 ]
do
    case "$1" in
        --input)
            inputdir="$2"
            shift 2
            ;;
        --dataset)
            datasetdir="$2"
            shift 2
            ;;
        --output)
            outputdir="$2"
            shift 2
            ;;
        --image)
            image="$2"
            shift 2
            ;;
        *)
            die "unknown option: $1"
    esac
done

[ -d "$inputdir" ] || die "input not found: $inputdir"
[ -d "$datasetdir" ] || die "dataset not found: $datasetdir"
[ -d "$outputdir" ] || mkdir "$outputdir" || die "output not found: $outputdir"
[ -n "$image" ] || die "no docker image name"

inputdir=$(realpath "$inputdir")
datasetdir=$(realpath "$datasetdir")
outputdir=$(realpath "$outputdir")

opts="$opts --rm -it"
opts="$opts --gpus all"
opts="$opts -e HOST_UID=$(id -u) -e HOST_GID=$(id -g)"
opts="$opts -v$inputdir:/train/input:ro -v$datasetdir:/train/dataset -v$outputdir:/train/output -w/train"

docker run $opts "$image" bash input/train.sh
