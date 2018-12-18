#!/usr/bin/env python
# coding=utf-8
from __future__ import print_function, unicode_literals
import sys

try:
    # compatible for python2
    from urllib import urlencode
    from urllib2 import urlopen
    from urllib2 import Request
    from urllib2 import URLError
except ImportError:
    # compatible for python3
    from urllib.parse import urlencode
    from urllib.request import urlopen
    from urllib.request import Request
    from urllib.error import URLError

url_login = 'http://p.nju.edu.cn/portal_io/login'

if len(sys.argv) > 2:
    print('%s [user]' % (sys.argv[0]))
    sys.exit(0)

username = raw_input("Input StudentID:")
password = raw_input("Input Password:")

#print(username, password)

post_data = urlencode({'username': username, 'password': password})

post_data = post_data.encode('utf-8')

header = {
    'Accept': 'application/json, test/javascript, */*; q=0.01',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Host': 'p.nju.edu.cn',
    'Origin': 'http://p.nju.edu.cn',
    'Proxy-Connection': 'keep-alive',
    'Referer': 'http://p.nju.edu.cn/portal/index.html?v=201606170634',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Gecko/20100101 Firefox/32.0'
}
req = Request(url_login, post_data, header)
print(urlopen(req).read())
