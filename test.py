#!/usr/bin/python
from __future__ import print_function
from six.moves.urllib.request import urlopen

import ftplib
import telnetlib

try:
    import urllib.request as urllib_request  # Python 3
except ImportError:
    import urllib2 as urllib_request  # Python 2

# Import SocksiPy
import sockschain as socks
def DEBUG(msg): print(msg)
socks.DEBUG = DEBUG

# Set the proxy information
#socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, 'localhost', 9050)
socks.setdefaultproxy(socks.PROXY_TYPE_HTTP, 'klaki.net', 18080)

# Route an HTTP request through the SOCKS proxy 
socks.wrapmodule(urllib_request)
print(urlopen('http://bot.whatismyipaddress.com/').read())

# Route an FTP session through the SOCKS proxy 
#socks.wrapmodule(ftplib)
#ftp = ftplib.FTP('cdimage.ubuntu.com')
#ftp.login('anonymous', 'support@aol.com')
#print ftp.dir('cdimage')
#ftp.close()

# Route a telnet connection through the SOCKS proxy
socks.wrapmodule(telnetlib)
tn = telnetlib.Telnet('achaea.com')
print(tn.read_very_eager())
tn.close()
