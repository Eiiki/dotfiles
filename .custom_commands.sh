#!/bin/bash

function mkvirtualenv3() {
    python3 -m venv ~/.virtualenvs/$1
}

function workon3() {
    source ~/.virtualenvs/$1/bin/activate
}
