#!/bin/bash

unset GREP_OPTIONS
ASBASE=asian-sister

LAST=`ls htmls/albums/view_* | egrep -o "view_[0-9]{4}_" | egrep -o "[0-9]+" | sort | tail -n1`
echo ===== fetching from $LAST

all_proxy="socks5h://127.0.0.1:19999"

urls=`curl --url "https://asiansister.com/" | \
	egrep -o "view_[^']+" | \
	awk -v last=$LAST -F_ '{if($2>last)print$0}' | \
	sort`

for url in $urls
do
	echo ===== processing $url
	curl -o htmls/albums/$url.html https://asiansister.com/$url 
	for img in $(egrep -o "dataUrl='[^']+'" "htmls/albums/$url.html" | sed "s/dataUrl='.....\(.*\/\([0-9]\+\)_\([0-9]\+\).*\)'/\2,\3,\1/g")
	do
		alb=$(cut -d',' -f1 <<< $img)
		idx=$(cut -d',' -f2 <<< $img)
		url=$(cut -d',' -f3 <<< $img)
		echo ===== fetching $img === $alb = $idx = $url 
		mkdir -p site/$alb
		curl -C - -o site/$alb/$idx.jpg "https://asiansister.com/$url"
	done
done
