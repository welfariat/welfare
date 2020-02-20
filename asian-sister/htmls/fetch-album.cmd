echo off
set CURL_HEADERS=^
	-H "authority: asiansister.com" ^
	-H "pragma: no-cache" ^
	-H "cache-control: no-cache" ^
	-H "dnt: 1" ^
	-H "upgrade-insecure-requests: 1" ^
	-H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/82.0.4055.2 Safari/537.36" ^
	-H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" ^
	-H "sec-fetch-site: none" ^
	-H "sec-fetch-mode: navigate" ^
	-H "sec-fetch-user: ?1" ^
	-H "sec-fetch-dest: document" ^
	-H "accept-language: en,zh-CN;q=0.9,zh;q=0.8,en-US;q=0.7,zh-TW;q=0.6" ^
	-H "cookie: HstCfa4130490=1578305975370; _ga=GA1.2.35757242.1578305985; __dtsu=1EE704453E51195E77624B8A0224E71C; __dtsu=1EE704453E51195E77624B8A0224E71C; __cfduid=dbda0909ccf2a570cb438b62705ec5ca31581160184; HstCmu4130490=1581160468515; cf_clearance=f57d325711391f12b581effa4b56e47e95006711-1581946334-0-220; PHPSESSID=b60986f995cb3a2afd3c68e385715b8a; HstCla4130490=1581946336476; HstPn4130490=1; HstPt4130490=32; HstCnv4130490=13; HstCns4130490=18; _gid=GA1.2.1568266281.1581946340" ^
	-x "socks5h://127.0.0.1:19050"

for /F "tokens=*" %%L in (%1) do (
	if not exist "albums-current\%%L.html" (
		echo ========= %%L === downloading...
		curl -o "albums-current\%%L.html" --url "https://asiansister.com/%%L.html" %CURL_HEADERS%
	)
REM else echo \%%L.html existed and ignored.
)
