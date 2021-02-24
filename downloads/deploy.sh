#!/bin/bash

{

# Exit on error
# set -o errexit # TODO: fix this not running python
set -o errtrace

function help() {
    echo "\
Deploys STLs to GitHub pages.

Usage:
./deploy.sh
"
}

function bonk() {
    printf "\a"
}

function run() {
    # TODO: fail if git status is dirty

    dir=$(./make_stls.sh -e)
    mkdir -pv $dir

    # TODO: fail if STLs aren't being made or already made

    if [[ "$1" == *"-b"* ]]; then
        echo "MAKING STLS + ZIP"
        echo "-----------------"
        echo
        rm -rf $dir
        ./make_stls.sh -d "$dir"
        echo
    fi

    echo "BUILDING SITE"
    echo "-------------"
    echo
    python downloads/build.py --directory "$dir"
    echo "Done!"
    echo

    echo "COMMITTING"
    echo "----------"
    echo
    git checkout gh-pages
    rm *.stl
    rm *.zip
    cp $dir/* "."

    git add .
    git commit -m "Deploy $dir"

    if [[ "$1" == *"--do-it-live"* ]]; then
        echo
        echo "DEPLOYING"
        echo "---------"
        echo
        git push origin gh-pages
    fi

    git checkout "@{-1}"

    bonk
}

# Send full args string w/ spaces
run "$*"

}
