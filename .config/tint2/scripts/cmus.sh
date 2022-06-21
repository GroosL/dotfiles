#!/bin/bash

artis=$(cmus-remote -Q | grep 'tag artist' | cut -d ' ' -f 3-)
title=$(cmus-remote -Q | grep title | cut -d ' ' -f 3-)
album=$(cmus-remote -Q | grep album | cut -d ' ' -f 3-)
duration=$(cmus-remote -Q | grep duration | cut -d ' ' -f 2-)
position=$(cmus-remote -Q | grep position | cut -d ' ' -f 2-)
last=$(echo - | awk -v "S=$position" '{printf "%02d:%02d:%02d",S/(60*60),S%(60*60)/60,S%60}'|cut -b 4-)
total=$(echo - | awk -v "S=$duration" '{printf "%02d:%02d:%02d",S/(60*60),S%(60*60)/60,S%60}'|cut -b 4-)

echo $title - $artis $last



