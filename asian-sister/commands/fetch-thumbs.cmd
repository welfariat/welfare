echo off 
set CURL_OTHER_ARGS=-H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,zh-CN;q=0.8,en;q=0.5,zh-TW;q=0.3" -H "DNT: 1" -H "Connection: keep-alive" -H "Cookie: __cfduid=d50c6283f91617b593e8f4b7c7e2e9bf61577707894; cf_clearance=145b977161d7e9e75f55d2a9bfb37477309a40e6-1577948339-0-220" -H "Upgrade-Insecure-Requests: 1"

set GREP_DST_ARG1="(<div id='detailBox' class='detailBoxHide' style='color:#FFFFFF;'>.*</h4>)|(<img class='lazyload imageShow' [^>]+>)|<h1>[^>]+</h1>"
for /F "delims=, tokens=1,2,3" %%L in (2-content-detail.list) do (
	mkdir "2-content\%%L\thumbs"
	curl -x socks5h://127.0.0.1:19050 -o "2-content\%%L\thumbs\%%M.jpg" --url "%%N_t" %CURL_OTHER_ARGS%
)