#!/bin/bash

#https://www.weibo.com/1805026874/Iv6480pGj

unset GREP_OPTIONS
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

dsturl=https://www.weibo.com/${1/-/\/}
dstpath=${1/\//-}
mkdir -p site/$dstpath

for img in $(curl -s "$dsturl" -H "authority: www.weibo.com" -H "dnt: 1" -H "upgrade-insecure-requests: 1" \
  -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/82.0.4055.2 Safari/537.36" \
  -H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" \
  -H "sec-fetch-site: none" -H "sec-fetch-mode: navigate" -H "sec-fetch-user: ?1" -H "sec-fetch-dest: document" -H "accept-language: en,zh-CN;q=0.9,zh;q=0.8,en-US;q=0.7,zh-TW;q=0.6" \
  -H "cookie: SINAGLOBAL=9746436240919.238.1560838368359; SCF=AuzoXtkUmvE0V-3-HaRNxOM2CYyOAfoyFXKw0AeGaUgGXrH1PrFGy2_lT6EMKQMjh8R1LqEGz7hyLBenmYDlPBE.; SUHB=00x5XwElPqMhPM; ALF=1610245579; SUB=_2AkMpF-dXf8NxqwJRmP4Tz2zmb4t2yA7EieKfSxaMJRMxHRl-yT92qhMctRB6ApfJuIJ1ZNxTCbcAuOMdjygEU9jRRKen; SUBP=0033WrSXqPxfM72-Ws9jqgMF55529P9D9WF-9JHe5w31YwWoMaFTwgTD; ULV=1582110291507:6:2:2:942289062340.7621.1582110290603:1582000228416" \
 | egrep -o "clear_picSrc=[^&]+" | egrep -o "%2F%2Fwx[^,]+")
do
  echo https:$(urldecode "$img") | sed "s/mw690/large/g" >> $dstpath.list
done
cat $dstpath.list
. weibo-c.sh $dstpath