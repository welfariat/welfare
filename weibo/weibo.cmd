set TU=%1
set TID=%TU:/=-%
echo list in %TID%.list
mkdir %TID%

set URL=%1
set UR=%URL:-=/%

curl -s "https://www.weibo.com/%UR%" ^
  -H "authority: www.weibo.com" ^
  -H "dnt: 1" ^
  -H "upgrade-insecure-requests: 1" ^
  -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/82.0.4055.2 Safari/537.36" ^
  -H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" ^
  -H "sec-fetch-site: none" ^
  -H "sec-fetch-mode: navigate" ^
  -H "sec-fetch-user: ?1" ^
  -H "sec-fetch-dest: document" ^
  -H "accept-language: en,zh-CN;q=0.9,zh;q=0.8,en-US;q=0.7,zh-TW;q=0.6" ^
  -H "cookie: SINAGLOBAL=9746436240919.238.1560838368359; SCF=AuzoXtkUmvE0V-3-HaRNxOM2CYyOAfoyFXKw0AeGaUgGXrH1PrFGy2_lT6EMKQMjh8R1LqEGz7hyLBenmYDlPBE.; SUHB=00x5XwElPqMhPM; ALF=1610245579; SUB=_2AkMpF-dXf8NxqwJRmP4Tz2zmb4t2yA7EieKfSxaMJRMxHRl-yT92qhMctRB6ApfJuIJ1ZNxTCbcAuOMdjygEU9jRRKen; SUBP=0033WrSXqPxfM72-Ws9jqgMF55529P9D9WF-9JHe5w31YwWoMaFTwgTD; ULV=1582110291507:6:2:2:942289062340.7621.1582110290603:1582000228416" ^
 | egrep -o "clear_picSrc=[^&]+" | tr , \n | sed "s/%%2F/\//g;s/^.*\/\//https:\/\//g;s/\/mw690\//\/large\//g" > %TID%.list
REM | egrep -o "pic_id=[0-9a-zA-Z]+" | sed "s/pic_id=/https:\/\/wx3.sinaimg.cn\/large\//g;s/$/.jpg/g"
wget -c -i %TID%.list -P %TID% -b -o %TID%.log
tail %TID%.log