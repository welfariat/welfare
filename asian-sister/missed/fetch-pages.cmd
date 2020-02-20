echo off
set CURL_HEADERS=-H "authority: asiansister.com" -H "cache-control: max-age=0" -H "upgrade-insecure-requests: 1" -H "dnt: 1" -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4018.0 Safari/537.36" -H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -H "sec-fetch-site: cross-site" -H "sec-fetch-mode: navigate" -H "sec-fetch-user: ?1" -H "sec-fetch-dest: document" -H "referer: http://asiansister.com/" -H "accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7" -H "cookie: cf_clearance=0e9650174890953d367a8c44aea689d3a270de8e-1578305917-0-250; __cfduid=dd2848c099abeda2f05a7a521a88818ac1578305917; PHPSESSID=08a5cee1f44d4de5c460141a6ec68248"
set GREP_DST_ARG1="(Model / Actor</div><a href='[^']+')|(<h1>.*</h1>)|(<img class='lazyload showMiniImage'[^>]+>)"
set GREP_DST_ARG2="(<a href='[^']+')|(<h1>.*</h1>)|(dataUrl='[^']+')|(data-src='[^']+')"
set SED_ARG0="s/<a href='\(.*\)'/<h2>https:\/\/asiansister.com\/\1<\/h2>/g;s/'$//g;s/dataUrl='...../https:\/\/asiansister.com\//g;s/data-src='/https:\/\/asiansister.com\//g"

for /F "tokens=*" %%L in (index-missed.list) do (
    echo Fetching %%L for missed...
    curl -o "raw\%%L.html" -x socks5h://127.0.0.1:19050 --url "https://asiansister.com/%%L" %CURL_HEADERS%
)