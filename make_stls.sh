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

function export_stl() {
    stub="$1"

    filename="$dir/$prefix-$stub-$timestamp-$commit_hash.stl"

    echo "Exporting $filename..."

    $openscad "openscad/enclosure.scad" \
        -o "$filename" \

    echo
}

export_stl $1

}
