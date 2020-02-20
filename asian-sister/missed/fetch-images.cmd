echo off
set CURL_HEADERS=^
	-H "authority: asiansister.com" ^
	-H "pragma: no-cache" ^
	-H "cache-control: no-cache" ^
	-H "dnt: 1" ^
	-H "upgrade-insecure-requests: 1" ^
	-H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4020.0 Safari/537.36" ^
	-H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" ^
	-H "sec-fetch-site: none" ^
	-H "sec-fetch-mode: navigate" ^
	-H "sec-fetch-user: ?1" ^
	-H "sec-fetch-dest: document" ^
	-H "accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7" ^
	-H "cookie: __cfduid=dd2848c099abeda2f05a7a521a88818ac1578305917; HstCfa4130490=1578305975370; HstCmu4130490=1578305975370; HstPn4130490=1; _ga=GA1.2.35757242.1578305985; PHPSESSID=8e25f6abf7d94fda4e4345cf50ab1876; HstCla4130490=1578380540289; HstCns4130490=2; HstCnv4130490=2; HstPt4130490=2; cf_clearance=390c2cd4c80c951f61f46f9faca85468b9f5f8a9-1578402677-0-250" ^
	-x socks5h://127.0.0.1:19050

for /F "delims=, tokens=1,2,3" %%L in (images-missed-rev%1.list) do (
	if not exist "content\%%L\%%M.jpg" (
		echo ========= %%L\%%M === %%N downloading...
		curl -o "content\%%L\%%M.jpg" --url "%%N" %CURL_HEADERS%
	) else echo %%L/%%M.jpg existed and ignored.
)
