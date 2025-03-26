#!/usr/bin/python

import telnetlib
import urllib.request as urllib_request  # Python 3
from urllib.request import urlopen

# Import SocksiPy
import sockschain as socks
def DEBUG(msg): print(msg)
socks.DEBUG = DEBUG

# Set the proxy information
socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, 'localhost', 9050)

# Route an HTTP request through the SOCKS proxy 
socks.wrapmodule(urllib_request)
print('\n%s\n' % urlopen('https://wtfismyip.com/text').read())

# Route a telnet connection through the SOCKS proxy
socks.wrapmodule(telnetlib)
tn = telnetlib.Telnet('india.colorado.edu', 13)
print(tn.read_all())
tn.close()
