echo off
set CURL_OTHER_ARGS=-H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,zh-CN;q=0.8,en;q=0.5,zh-TW;q=0.3" -H "DNT: 1" -H "Alt-Used: cflarexljc3rw355ysrkrzwapozws6nre6xsy3n4yrj7taye3uiby3ad.onion" -H "Connection: keep-alive" -H "Cookie: __cfduid=d50c6283f91617b593e8f4b7c7e2e9bf61577707894; login=true; status=member; userName=zbutfly"%"40gmail.com; displayName="%"E0"%"A4"%"AA"%"E0"%"A5"%"8D"%"E0"%"A4"%"AF"%"E0"%"A4"%"BE"%"E0"%"A4"%"95; PHPSESSID=ebb68aabc91d2411e3c02a46999a4b20; cf_clearance=145b977161d7e9e75f55d2a9bfb37477309a40e6-1577948339-0-220; view_i=162" -H "Upgrade-Insecure-Requests: 1" -H "TE: Trailers"
E:
cd E:\MediaX\processing\asian-sister
for /F "tokens=*" %%L in (lists\\index%1.list) do (
    echo fetch tags from %%L
    echo %%L >> album-tags-%1.list
    curl -x socks5h://127.0.0.1:19050 %CURL_OTHER_ARGS% --url "https://asiansister.com/%%L" | egrep -o "tegItem.>[^<]*<" | sed "s/tegItem.>\([^<]*\)</\1/g" | tr "\n\r" "," >> album-tags-%1.list
)