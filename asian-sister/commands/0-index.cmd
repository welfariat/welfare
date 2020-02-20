echo off
set CURL_HEADERS=-H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,zh-CN;q=0.8,en;q=0.5,zh-TW;q=0.3" -H "DNT: 1" -H "Alt-Used: cflarexljc3rw355ysrkrzwapozws6nre6xsy3n4yrj7taye3uiby3ad.onion" -H "Connection: keep-alive" -H "Cookie: __cfduid=d50c6283f91617b593e8f4b7c7e2e9bf61577707894; login=true; status=member; userName=zbutfly"%"40gmail.com; displayName="%"E0"%"A4"%"AA"%"E0"%"A5"%"8D"%"E0"%"A4"%"AF"%"E0"%"A4"%"BE"%"E0"%"A4"%"95; PHPSESSID=7f026a131fbb03c51aee6d780603e680; cf_clearance=fa2ed04afd02dbf29f873526d75322d47e864a8e-1578281781-0-250" -H "Upgrade-Insecure-Requests: 1" -H "TE: Trailers"
set CURL_PROXY_HTTP=-U zx:foxy,926 -x edge1.corp.hzcominfo.com:8080
set CURL_PROXY_SOCKS5=-x socks5h://127.0.0.1:19050

set GREP_DST_ARG1="(<div id='detailBox' class='detailBoxHide' style='color:#FFFFFF;'>.*</h4>)|(<img class='lazyload imageShow' [^>]+>)|<h1>[^>]+</h1>"

set SED_ARG_0="s/'view_/\n'https:\/\/asiansister.com\/view_/g;s/data-src=\"/\"https:\/\/asiansister.com\//g;s/alt=//g"
set GREP_ARG_0="(href='view_[0-9]+_.*')|(data-src=.*alt='[^']+')"
set GREP_ARG_1="('view_[0-9]+_[^']*')|(data-src=\".+\")|(alt='[^']+')"

curl -x socks5h://127.0.0.1:19050 %CURL_HEADERS% -o "lists\raw\page-1.html" --url "https://asiansister.com/"
REM curl -s -U zx:foxy,926 -x edge1.corp.hzcominfo.com:8080 --url https://asiansister.com/_page%%i | egrep %GREP_ARG_0% | egrep -o %GREP_ARG_1% | sed %SED_ARG_0% >> 0-index.txt
for /l %%i in (2,1,11) do (
    echo Fetching page %%i
    curl -o "lists\raw\page-%%i.html" -x socks5h://127.0.0.1:19050 "https://asiansister.com/_page%%i" %CURL_HEADERS%
)

for /l %%i in (12,1,21) do (
    echo Fetching page %%i
    curl -o "lists\raw\page-%%i.html" -x socks5h://127.0.0.1:19050 "https://asiansister.com/_page%%i" %CURL_HEADERS%
)

for /l %%i in (22,1,31) do (
    echo Fetching page %%i
    curl -o "lists\raw\page-%%i.html" -x socks5h://127.0.0.1:19050 "https://asiansister.com/_page%%i" %CURL_HEADERS%
)

for /l %%i in (32,1,41) do (
    echo Fetching page %%i
    curl -o "lists\raw\page-%%i.html" -x socks5h://127.0.0.1:19050 "https://asiansister.com/_page%%i" %CURL_HEADERS%
)
