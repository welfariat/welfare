#!/bin/bash

unset GREP_OPTIONS
ASBASE=asian-sister

LAST=`ls htmls/albums/view_* | egrep -o "view_[0-9]{4}_" | egrep -o "[0-9]+" | sort | tail -n1`
echo ===== fetching from $LAST

urls=`curl -x "http://zx:foxy,926@edge1.corp.hzcominfo.com:8080" "https://asiansister.com/" | egrep -o "view_[^']+" | awk -v last=$LAST -F_ '{if($2>last)print$0}' | sort`
echo $urls

for url in $urls
do
	echo ===== processing $url
	curl -x "http://zx:foxy,926@edge1.corp.hzcominfo.com:8080" -o htmls/albums/$url.html --url https://asiansister.com/$url 
	for img in $(egrep -o "dataUrl='[^']+'" "htmls/albums/$url.html" | sed "s/dataUrl='.....\(.*\/\([0-9]\+\)_\([0-9]\+\).*\)'/\2,\3,\1/g")
	do
		alb=$(cut -d',' -f1 <<< $img)
		idx=$(cut -d',' -f2 <<< $img)
		url=$(cut -d',' -f3 <<< $img)
		echo ===== fetching $img === $alb = $idx = $url
		mkdir -p site/$alb
		curl -x "http://zx:foxy,926@edge1.corp.hzcominfo.com:8080" -C - --retry 100 --retry-delay 1 -o site/$alb/$idx.jpg --url "https://asiansister.com/$url"
	done
done
