import requests
from lxml import html


hproxy = 'http://zx:foxy,926@edge1.corp.hzcominfo.com:8080'
myheaders = {
    # 'authority': 'asiansister.com',
    'cache-control': 'max-age=0',
    'upgrade-insecure-requests': '1',
    'dnt': '1',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4018.0 Safari/537.36',
    'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'sec-fetch-site': 'cross-site',
    'sec-fetch-mode': 'navigate',
    'sec-fetch-user': '?1',
    'sec-fetch-dest': 'document',
    'referer': 'http://asiansister.com/',
    'accept-language': 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
    'cookie': 'cf_clearance=0e9650174890953d367a8c44aea689d3a270de8e-1578305917-0-250; __cfduid=dd2848c099abeda2f05a7a521a88818ac1578305917; PHPSESSID=08a5cee1f44d4de5c460141a6ec68248',
}
myproxies = dict(http='socks5h://127.0.0.1:19050',
                 https='socks5h://127.0.0.1:19050')
myproxies = dict(http='http://zx:foxy,926@edge1.corp.hzcominfo.com:8080',
                 https='http://zx:foxy,926@edge1.corp.hzcominfo.com:8080')

# with open('missed/index-missed.list', 'r') as f:
#     for line in f:
#         resp = requests.get('https://asiansister.com/' +
#                             line, headers=myheaders, proxies=myproxies)
#         if resp.status_code != 200:
#             print('Http fail ['+str(resp.status_code)+'] on ' + line)
#             continue
#         else: print('parsing: ' + line)
#         dom = html.fromstring(resp.text)
#         div = dom.xpath('/html/body/center/div[2]')
#         print(div.children)
#         img = dom.xpath('//*[@id="show0"]')
#         img.at
#         print(img)
#         exit

with open('missed/raw/view_294_m_Nyeskura__Sexy_loli_girl_show_her_pink_shaved_pussyn.html', 'r') as f:
    content = f.readlines
    content
    dom = html.fromstring(content)
div = dom.xpath('/html/body/center/div[2]')
print(div.children)
img = dom.xpath('//*[@id="show0"]')
img.at
print(img)
