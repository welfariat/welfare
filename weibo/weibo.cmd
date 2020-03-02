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
  -H "Cookie: SINAGLOBAL=7312468128204.368.1578709958035; ULV=1578709958037:1:1:1:7312468128204.368.1578709958035:; SCF=AgcsDwIO3vtTjsJ3FEuUOfxOMkTU0XUDbPqOSIrsHw8iTML46W-EHGMaZZ-03proVLYAXg1n74VTFAYs1Y1Ld4c.; SUHB=0Ry6baPd8ce4Qv; ALF=1614431433; un=zbutfly@163.com; wvr=6; SUBP=0033WrSXqPxfM725Ws9jqgMF55529P9D9W5z2BX.EI_1BkvmfUkqMc.F5JpX5KMhUgL.Foz4S02ESh5pehB2dJLoIEXLxK-LB-BL1KBLxK.L1-zL1h5LxKqLB-BLB.zLxK-LB-BL1KBLxK.L1-zL1h5t; YF-V5-G0=b588ba2d01e18f0a91ee89335e0afaeb; SUB=_2A25zXWHKDeRhGeRH7FMT9C7NyziIHXVQK9QCrDV8PUNbmtAfLUemkW9NTdEu_yn4Bvb8eOkfYUmCRbHSF6RU87fn; SSOLoginState=1582895514; YF-Page-G0=afcf131cd4181c1cbdb744cd27663d8d|1582959956|1582959956; TC-V5-G0=eb26629f4af10d42f0485dca5a8e5e20; wb_view_log_2971240104=2304*12961.6666666666666667; TC-Page-G0=04dc502e635144031713f186989293c7|1582963030|1582962939" ^
 | egrep -o "clear_picSrc=[^&]+" | tr , \n | sed "s/%%2F/\//g;s/^.*\/\//https:\/\//g;s/\/mw690\//\/large\//g" > %TID%.list
REM | egrep -o "pic_id=[0-9a-zA-Z]+" | sed "s/pic_id=/https:\/\/wx3.sinaimg.cn\/large\//g;s/$/.jpg/g"
wget -c -i %TID%.list -P %TID% -b -o %TID%.log
tail %TID%.log