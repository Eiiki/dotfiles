#!/bin/bash

function mkvirtualenv3() {
    python3 -m venv ~/.virtualenvs/$1
}

function workon3() {
    source ~/.virtualenvs/$1/bin/activate
}

function gitopen {
    if [ -d .git ]; then
        remotes=$(git remote -v | awk -F'git@github.com:' '{print $2}' | cut -d" " -f1)
        if [ -z "$remotes" ];
            then
                remotes=$(git remote -v | awk -F'https://github.com/' '{print $2}' | cut -d" " -f1)
        fi

        remote_url=$(echo $remotes | cut -d" " -f1)
        url="https://github.com/"
        branch=$(git name-rev --name-only HEAD)
        url="${url}${remote_url%.*}/tree/${branch}/"
        #echo "${branch%.*}"
        /usr/bin/open -a "/Applications/Google Chrome.app" $url
    else
        echo "Not a git repo"
    fi;
}
