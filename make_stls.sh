#!/bin/bash

{

# Exit on error
set -o errexit
set -o errtrace

prefix="apc"

openscad="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
timestamp=$(git --no-pager log -1 --date=unix --format="%ad")
commit_hash=$(git rev-parse --short HEAD)
dir="local/3d-models/$timestamp-$commit_hash"

mkdir -pv $dir

function confirm_poly555_branch() {
    pushd ../poly555  > /dev/null
    poly555_branch=$(git branch --show-current)
    popd > /dev/null

    read -p "poly555 is on branch $poly555_branch. Continue? " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo
        echo
    else
        exit
    fi
}

function export_stl() {
    stub="$1"
    override="$2"
    flip_vertically="$3"

    filename="$dir/$prefix-$stub-$timestamp-$commit_hash.stl"

    echo "Exporting $filename..."

    # The "& \" at the end runs everything in parallel!
    $openscad "openscad/apc.scad" \
        -o "$filename" \
        -D 'SHOW_ENCLOSURE_TOP=false' \
        -D 'SHOW_ENCLOSURE_BOTTOM=false' \
        -D 'SHOW_PCB=false' \
        -D 'SHOW_WHEELS=false' \
        -D 'SHOW_SWITCH_CLUTCH=false' \
        -D 'SHOW_BATTERY=false' \
        -D 'SHOW_DFM=true' \
        -D 'WHEELS_COUNT=1' \
        -D "FLIP_VERTICALLY=$flip_vertically" \
        -D "$override=true" \
        & \
}

function finish() {
    # Kill descendent processes
    pkill -P "$$"
}
trap finish EXIT

confirm_poly555_branch

start=`date +%s`

export_stl 'enclosure_bottom' 'SHOW_ENCLOSURE_BOTTOM' 'false'
export_stl 'enclosure_top' 'SHOW_ENCLOSURE_TOP' 'true'
export_stl 'switch_clutch' 'SHOW_SWITCH_CLUTCH' 'false'
export_stl 'wheels' 'SHOW_WHEELS' 'false'
wait

end=`date +%s`
runtime=$((end-start))

echo
echo "Finished in $runtime seconds"

}
