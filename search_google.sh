#!/bin/bash

url='https://google.com/search?q='
query=$(zenity --entry --text 'Search Google:')
query="${query// /+}"
if [ -n "$query" ]; then
    xdg-open "$url$query" 2> /dev/null
fi
