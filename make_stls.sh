#!/bin/bash

{

# Exit on error
set -o errexit
set -o errtrace

prefix="apc"
zip_prefix="oskitone"
query=
openscad="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
timestamp=$(git --no-pager log -1 --date=unix --format="%ad")
commit_hash=$(git rev-parse --short HEAD)
dir="local/3d-models/$timestamp-$commit_hash"

found_matches=""

function help() {
    echo "\
Renders APC STL models.

Usage:
./make_stls.sh [-h] [-p PREFIX] [-q comma,separated,query]

Usage:
./make_stls.sh                    Export all STLs
./make_stls.sh -h                 Show this message
./make_stls.sh -p <stl_prefix>    Set STL filename prefix. Default is 'apc'
./make_stls.sh -z <zip_prefix>    Set ZIP filename prefix. Default is 'oskitone'
./make_stls.sh -q <query>         Export all STLs whose filename stubs match
                                  comma-separated query

Examples:
./make_stls.sh -p test -q switch  Exports test-switch_clutch-....stl
./make_stls.sh -p wheels,enc      Exports apc-wheels-....stl,
                                  apc-enclosure_bottom-....stl,
                                  and apc-enclosure_top-....stl
"
}

function note_poly555_branch() {
    pushd ../poly555 > /dev/null
    poly555_branch=$(git branch --show-current)
    popd > /dev/null

    echo "NOTE: poly555 is on branch '$poly555_branch'."
    echo
}

function export_stl() {
    stub="$1"
    override="$2"
    flip_vertically="$3"

    function _run() {
        filename="$dir/$prefix-$stub-$timestamp-$commit_hash.stl"

        echo "Exporting $filename..."

        # The "& \" at the end runs everything in parallel!
        $openscad "openscad/apc.scad" \
            --quiet \
            -o "$filename" \
            --export-format "binstl" \
            -D 'SHOW_ENCLOSURE_TOP=false' \
            -D 'SHOW_ENCLOSURE_BOTTOM=false' \
            -D 'SHOW_PCB=false' \
            -D 'SHOW_WHEELS=false' \
            -D 'SHOW_SWITCH_CLUTCH=false' \
            -D 'SHOW_BATTERY=false' \
            -D 'SHOW_DFM=true' \
            -D 'WHEELS_COUNT=1' \
            -D "CENTER=true" \
            -D "FLIP_VERTICALLY=$flip_vertically" \
            -D "$override=true" \
            & \
    }

    if [[ -z "$query" ]]; then
        _run
    else
        for query_iterm in "${query[@]}"; do
            if [[ "$stub" == *"$query_iterm"* ]]; then
                found_matches=true
                _run
            fi
        done
    fi
}

function create_zip() {
    if [[ -z "$query" ]]; then
        echo "Creating zip"
        pushd $dir
        zip "$zip_prefix-$prefix-$timestamp-$commit_hash.zip" *.stl
        popd > /dev/null
    fi
}

function bonk() {
    printf "\a"
}

function run() {
    mkdir -pv $dir

    function finish() {
        # Kill descendent processes
        pkill -P "$$"
    }
    trap finish EXIT

    note_poly555_branch

    start=`date +%s`

    export_stl 'enclosure_bottom' 'SHOW_ENCLOSURE_BOTTOM' 'false'
    export_stl 'enclosure_top' 'SHOW_ENCLOSURE_TOP' 'true'
    export_stl 'switch_clutch' 'SHOW_SWITCH_CLUTCH' 'false'
    export_stl 'wheels' 'SHOW_WHEELS' 'false'
    wait

    end=`date +%s`
    runtime=$((end-start))

    if [[ "$query" && -z $found_matches ]]; then
        echo "Found no matches for query '$query'"
    else
        create_zip
        bonk
        open $dir
    fi

    echo
    echo "Finished in $runtime seconds"
}

while getopts "h?p:z:q:" opt; do
    case "$opt" in
        h) help; exit ;;
        p) prefix="$OPTARG" ;;
        z) zip_prefix="$OPTARG" ;;
        q) IFS="," read -r -a query <<< "$OPTARG" ;;
        *) help; exit ;;
    esac
done

run "${query[@]}"

}
